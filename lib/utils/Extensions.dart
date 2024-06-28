import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/providers/CartNotifier.dart';

extension ProductsExtension on Locale {
  String getProductName(Product product) {
    if (languageCode == "en") {
      return product.productNameEN;
    }
    return product.productNameAR;
  }

  String getProductDescription(Product product) {
    if (languageCode == "en") {
      return product.productDescriptionEN ?? "";
    }
    return product.productDescriptionAR ?? "";
  }
}
