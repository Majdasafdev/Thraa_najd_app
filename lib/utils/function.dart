import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/providers/cartItem.dart';

import '../models/oldProduct.dart';

/*
List<OldProduct> getProductByCategory(
    String kNuts, List<OldProduct> allproducts) {
  List<OldProduct> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == kNuts) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}

 */

/////////////////<THE CODE BELOW FOR PRODUCTINFO PAGE>//////////////////

int _quantity = 1;
