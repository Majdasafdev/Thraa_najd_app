import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/providers/CartNotifier.dart';
import 'package:thraa_najd_mobile_app/providers/SectionNotifier.dart';

extension ProductsExtension on Locale {
  String getProductName(Product product) {
    if (languageCode == "en") {
      return product.productNameEN;
    }
    return product.productNameAR;
  }

  String getProductCategory(Product product) {
    if (languageCode == "en") {
      return product.category.nameEN;
    }
    return product.category.nameAR;
  }
}
