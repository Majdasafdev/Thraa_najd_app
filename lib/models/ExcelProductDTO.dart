import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:excel/excel.dart';

import 'Category.dart';
import 'Product.dart';

part 'ExcelProductDTO.mapper.dart';

@MappableClass()
class ExcelProductDTO with ExcelProductDTOMappable {
  final String productId;
  final String materialId;
  final String productNameEN;
  final String productNameAR;
  final Category? category;
  final double costPrice;
  final ProductPrice retailPrice;
  final ProductPrice wholesalePrice;
  final Uint8List? imageLink;
  final bool stocked;

  const ExcelProductDTO(
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

  factory ExcelProductDTO.fromExcelData(
      {required List<Data?> data,
      required Uint8List image,
      bool throwExceptionWithError = false}) {
    final costPrice =
        double.tryParse(data[4]?.value.toString().trim() ?? "") ?? -1;
    final String retailUnitAR = data[5]!.value.toString().trim();
    final String retailUnitEN = data[6]!.value.toString().trim();
    final String wholeSaleUnitAR = data[7]!.value.toString().trim();
    final String wholeSaleUnitEN = data[8]!.value.toString().trim();
    final product = ExcelProductDTO(
        productId: "",
        materialId: data[0]?.value.toString().trim() ?? "",
        productNameEN: data[1]?.value.toString().trim() ?? "",
        productNameAR: data[2]?.value.toString().trim() ?? "",
        category: data[3]?.value == null
            ? null
            : CategoryMapper.fromValue(data[3]!.value.toString()),
        costPrice: costPrice,
        retailPrice: ProductPrice.calcRetail(
            costPrice: costPrice, unitAR: retailUnitAR, unitEN: retailUnitEN),
        wholesalePrice: ProductPrice.calcWholesalePrice(
            costPrice: costPrice,
            unitAR: wholeSaleUnitAR,
            unitEN: wholeSaleUnitEN),
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
}

@MappableClass()
class ProductPrice with ProductPriceMappable {
  final String unitAR;
  final String unitEN;
  final double price;

  const ProductPrice(
      {required this.unitEN, required this.unitAR, required this.price});

  static const fromMap = ProductPriceMapper.fromMap;

  static ProductPrice calcRetail(
      {required double costPrice,
      required String unitAR,
      required String unitEN}) {
    return ProductPrice(
        price: (costPrice > 1000 ? costPrice * 1.25 : costPrice * 1.30) / 10,
        unitAR: unitAR,
        unitEN: unitEN);
  }

  static ProductPrice calcWholesalePrice(
      {required double costPrice,
      required String unitAR,
      required String unitEN}) {
    return ProductPrice(
        unitAR: unitAR, unitEN: unitEN, price: costPrice * (1.30));
  }
}
