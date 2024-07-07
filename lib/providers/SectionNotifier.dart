import 'package:flutter/material.dart';

class SectionNotifier extends ChangeNotifier {
  bool isWholeSale = false;

  void setSection(bool isWholeSale) {
    this.isWholeSale = isWholeSale;
    notifyListeners();
  }
}
