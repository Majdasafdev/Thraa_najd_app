import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/SectionNotifier.dart';
import 'Category.dart';

part 'Product.mapper.dart';

@MappableClass()
class Product with ProductMappable {
  final String productId;
  final String materialId;
  final String productNameEN;
  final String productNameAR;
  final Category category;
  final double costPrice;
  final double retailPrice;
  final double wholesalePrice;
  final String imageLink;
  final bool stocked;

  const Product(
      {required this.productId,
      required this.materialId,
      required this.productNameEN,
      required this.productNameAR,
      required this.category,
      required this.costPrice,
      required this.retailPrice,
      required this.wholesalePrice,
      required this.imageLink,
      this.stocked = true});

  static get firebaseProductId => "productId";

  static get firebaseMaterialId => "materialId";

  static get firebaseCategory => "category";

  static get firebaseCostPrice => "costPrice";

  static get firebaseRetailPrice => "retailPrice";

  static get firebaseWholesalePrice => "wholesalePrice";

  static get firebaseImageLink => "imageLink";

  static get firebaseStocked => "stocked";

  static const fromMap = ProductMapper.fromMap;

  static double calcRetail(double costPrice) {
    return (costPrice > 1000 ? costPrice * 1.25 : costPrice * 1.30) / 10;
  }

  static double calcWholesalePrice(double costPrice) {
    return costPrice * (1.30);
  }

  double getProductPrice(BuildContext context) {
    return Provider.of<SectionNotifier>(context).isWholeSale
        ? wholesalePrice
        : retailPrice;
  }

  String get isStocked => stocked ? "Yes".tr() : "No".tr();
}
