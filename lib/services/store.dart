import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /*
  addProduct(OldProduct product) {
    _firestore.collection(kProductsCollection).add(
      {
        kProductName: product.pName,
        kProductDescription: product.pDescription,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory,
        kProductPrice: product.pPrice,
      },
    );
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
//  return DatabaseReference;
  }

  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection(
          kArProductsCollection); // or 'Products' based on your database

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  editProduct(
    data,
    documentId,
  ) {
    _firestore.collection(kProductsCollection).doc(documentId).update(data);
  }


   */
}
