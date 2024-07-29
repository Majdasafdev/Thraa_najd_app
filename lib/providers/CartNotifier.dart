import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/CartItem.dart';

import '../models/Product.dart';

class CartNotifier extends ChangeNotifier {
  //NOTE: Changed to Cart Items
  List<CartItem> cartItems = [];

  addCartItem(CartItem cartItem) {
    cartItems.add(cartItem);
    notifyListeners();
  }

  deleteCartItem(CartItem cartItem) {
    cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
