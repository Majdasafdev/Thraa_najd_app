import 'dart:io';
import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:excel/excel.dart';

import 'Category.dart';
import 'Product.dart';

part 'ProductDTO.mapper.dart';

@MappableClass()
class ProductDTO with ProductDTOMappable {
  final String productId;
  final String materialId;
  final String productNameEN;
  final String productNameAR;
  final Category? category;
  final double costPrice;
  final double retailPrice;
  final double wholesalePrice;
  final Uint8List? imageLink;
  final bool stocked;

  const ProductDTO(
      {required this.productId,
      required this.materialId,
      required this.productNameEN,
      required this.productNameAR,
      required this.category,
      required this.costPrice,
      required this.retailPrice,
      required this.wholesalePrice,
      required this.imageLink,
      required this.stocked});

  factory ProductDTO.fromExcelData(
      {required List<Data?> data,
      required Uint8List image,
      bool throwExceptionWithError = false}) {
    final costPrice =
        double.tryParse(data[5]?.value.toString().trim() ?? "") ?? -1;
    final product = ProductDTO(
        productId: "",
        materialId: data[0]?.value.toString().trim() ?? "",
        productNameEN: data[1]?.value.toString().trim() ?? "",
        productNameAR: data[2]?.value.toString().trim() ?? "",
        category: data[3]?.value == null
            ? null
            : CategoryMapper.fromValue(data[3]!.value.toString()),
        costPrice: costPrice,
        retailPrice: calcRetail(costPrice),
        wholesalePrice: calcWholesalePrice(costPrice),
        imageLink: image,
        stocked: true);

    if (throwExceptionWithError) {
      if (product.materialId.isEmpty ||
          product.costPrice < 1 ||
          product.productNameAR.isEmpty ||
          product.productNameEN.isEmpty) {
        throw Exception("Incorrect product data, check your excel sheet");
      }
    }

    return product;
  }

  Product toProduct({required String imageLink}) => Product(
      productId: productId,
      materialId: materialId,
      productNameEN: productNameEN,
      productNameAR: productNameAR,
      category: category ?? Category.nuts,
      costPrice: costPrice,
      retailPrice: retailPrice,
      wholesalePrice: wholesalePrice,
      imageLink: imageLink);

  static double calcRetail(double costPrice) {
    return (costPrice > 1000 ? costPrice * 1.25 : costPrice * 1.30) / 10;
  }

  static double calcWholesalePrice(double costPrice) {
    return costPrice * (1.30);
  }
}
