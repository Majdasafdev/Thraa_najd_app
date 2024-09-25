import 'dart:async';
import 'dart:ui';

import 'package:excel/excel.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../models/Category.dart';
import '../models/ExcelProductDTO.dart';
import '../models/Product.dart';
import '../utils/FirebaseConstants.dart';
import 'AbstractRepository.dart';

class ProductRepository extends AbstractRepository {
  Future<ByteData> loadNetworkAsset(String rawImageLink) async {
    return NetworkAssetBundle(Uri.parse(rawImageLink.trim()))
        .load(rawImageLink.trim());
  }

  Future<Uint8List> getImageBytes(String link) async {
    var imageBytes = await loadNetworkAsset(link);
    try {
      var result = await instantiateImageCodec(imageBytes.buffer.asUint8List());
      var next = await result.getNextFrame();
      return imageBytes.buffer.asUint8List();
    } catch (e, stk) {
      throw Exception(
          "The provided link is not an image link, with Error: ${e.toString()}");
    }
  }

  Future<List<ExcelProductDTO>> translateExcelSheet(String sheetPath) async {
    final data = Excel.decodeBytes(
        (await rootBundle.load(sheetPath)).buffer.asUint8List());

    final table = data.tables.entries.first.value.rows;
    table.removeAt(0);
    var emptyImage =
        (await rootBundle.load("assets/images/empty.jpg")).buffer.asUint8List();
    List<Future<Uint8List>> futureImages = table.map((e) async {
      if (e[9]?.value != null) {
        return getImageBytes(e[9]!.value.toString());
      }
      return emptyImage;
    }).toList();
    var images = (await futureImages.wait).map((e) {
      return e;
    });

    List<ExcelProductDTO> productDTOs = [];
    for (int i = 0; i < table.length; i++) {
      productDTOs.add(ExcelProductDTO.fromExcelData(
          data: table.elementAt(i), image: images.elementAt(i)));
    }
    return productDTOs;
  }

  Future<void> updateProductStockFlagByProductId(
      String productId, bool updatedFlag) async {
    await firebaseFirestore
        .collection(FirebaseConstants.productsCollection)
        .doc(productId)
        .update({Product.firebaseStocked: updatedFlag});
  }

  Future<void> addBulkProducts(List<ExcelProductDTO> productDTOs) async {
    var storageRef = firebaseStorage.ref();
    try {
      if (productDTOs.any((element) => element.imageLink == null)) {
        throw Exception("there are some missing images");
      }
      var imagesLinks = await productDTOs
          .map((e) => addImage(e.imageLink!, e.materialId))
          .wait;

      List<Product> products = [];
      for (int i = 0; i < productDTOs.length; i++) {
        products.add(productDTOs
            .elementAt(i)
            .toProduct(imageLink: imagesLinks.elementAt(i)));
      }

      var docsRefs = await products
          .map((e) => firebaseFirestore
              .collection(FirebaseConstants.productsCollection)
              .add(e.toMap()))
          .wait
          .onError((error, stackTrace) {
        if (error is ParallelWaitError) {
          print((error as ParallelWaitError).errors);
        }
        throw Exception(error.toString());
      });

      await docsRefs.map((element) {
        return element.update({Product.firebaseProductId: element.id});
      }).wait;
    } catch (e, stk) {
      await productDTOs.map((element) {
        return storageRef.child(element.materialId).delete();
      }).wait;
      rethrow;
    }
  }

  Future<bool> addProduct(
      {required ExcelProductDTO productDTO,
      required String rawImageLink}) async {
    try {
      if (productDTO.materialId.isEmpty) {
        throw Exception("No Empty Material Id Allowed");
      }
      if (productDTO.productNameAR.isEmpty ||
          productDTO.productNameEN.isEmpty ||
          productDTO.retailPrice.unitAR.isEmpty ||
          productDTO.retailPrice.unitEN.isEmpty ||
          productDTO.wholesalePrice.unitAR.isEmpty ||
          productDTO.wholesalePrice.unitEN.isEmpty) {
        throw Exception("No Empty Names Allowed!");
      }
      if (productDTO.costPrice < 1) {
        throw Exception("Cost Price is below 0");
      }
      if (rawImageLink.isEmpty) throw Exception("no image specified");

      var imageBytes = await getImageBytes(rawImageLink);
      productDTO = productDTO.copyWith(imageLink: imageBytes);

      var imageLink =
          await addImage(productDTO.imageLink!, productDTO.materialId);
      var product = productDTO.toProduct(imageLink: imageLink);
      var doc = await firebaseFirestore
          .collection(FirebaseConstants.productsCollection)
          .add(product.toMap());
      await doc.update({Product.firebaseProductId: doc.id});
      return true;
    } catch (e, stk) {
      await firebaseStorage.ref().child(productDTO.materialId).delete();
      rethrow;
    }
  }

  Future<bool> updateProduct(Product updatedProduct) async {
    var storageRef = firebaseStorage.ref();

    if (updatedProduct.materialId.isEmpty) {
      throw Exception("No Empty Material Id Allowed");
    }
    if (updatedProduct.productNameAR.isEmpty ||
        updatedProduct.productNameEN.isEmpty) {
      throw Exception("No Empty Names Allowed!");
    }
    if (updatedProduct.costPrice < 1) {
      throw Exception("Cost Price is below 0");
    }
    if (updatedProduct.imageLink.isEmpty) throw Exception("no image specified");

    var productDoc = firebaseFirestore
        .collection(FirebaseConstants.productsCollection)
        .doc(updatedProduct.productId);
    var currentProduct = Product.fromMap((await productDoc.get()).data()!);
    bool updatedImage = updatedProduct.imageLink != currentProduct.imageLink;
    String updatedImageLink = "";
    if (updatedImage) {
      var imageBytes = await getImageBytes(updatedProduct.imageLink);
      updatedImageLink = await addImage(imageBytes, updatedProduct.materialId);
    }

    var productMap = updatedImage
        ? updatedProduct.copyWith(imageLink: updatedImageLink)
        : updatedProduct;
    productDoc.update(productMap.toMap());
    return true;
  }

  Future<void> removeProductByProductId(String productId) async {
    await firebaseFirestore
        .collection(FirebaseConstants.productsCollection)
        .doc(productId)
        .delete();
  }

  Future<Product> getProductByProductId(String productId) async {
    var data = (await firebaseFirestore
        .collection(FirebaseConstants.productsCollection)
        .doc(productId)
        .get());
    if (data.data() == null) {
      throw Exception(
          "Error occurred when retrieving product, call the support to check the product data");
    }

    return Product.fromMap(data.data()!);
  }

  Future<void> removeAllProducts() async {
    var s = await firebaseStorage.ref().listAll();
    await s.items.map((e) => e.delete()).wait;
    await (await firebaseFirestore
            .collection(FirebaseConstants.productsCollection)
            .get())
        .docs
        .map((e) => e.reference.delete())
        .wait;
  }

  Future<String> addImage(Uint8List image, String path) async {
    var storageRef = firebaseStorage.ref();
    var task = await storageRef.child(path).putData(
        image,
        SettableMetadata(
          contentType: "image/jpg",
        ));
    if (task.state == TaskState.error) {
      throw Exception("failed to upload a product Image");
    }
    return await storageRef.child(path).getDownloadURL();
  }

  // getters

  Stream<IList<Product>> getAllProducts() {
    var stream = firebaseFirestore
        .collection(FirebaseConstants.productsCollection)
        .snapshots()
        .asyncMap((event) {
      return event.docs.map((e) => Product.fromMap(e.data())).toIList();
    });
    return stream;
/*
    return (await firebaseFirestore
            .collection(FirebaseConstants.productsCollection)
            .get())
        .docs
        .map((e) => Product.fromMap(e.data()))
        .toIList();

 */
  }

  Future<IList<Product>> getProductsByCategory(Category category) async {
    return (await firebaseFirestore
            .collection(FirebaseConstants.productsCollection)
            .where(Product.firebaseCategory, isEqualTo: category.toValue())
            .get())
        .docs
        .map((e) => Product.fromMap(e.data()))
        .toIList();
  }
}
