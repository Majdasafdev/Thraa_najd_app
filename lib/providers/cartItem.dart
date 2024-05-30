import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';

class CartItem extends ChangeNotifier {
  List<OldProduct> products = [];

  addProduct(OldProduct product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(OldProduct product) {
    products.remove(product);
    notifyListeners();
  }
}
