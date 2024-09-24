import 'package:flutter/material.dart';

class SectionNotifier with ChangeNotifier {
  bool _wholeSale = false;

  bool get isWholeSale => _wholeSale;

  void setSection(bool value) {
    _wholeSale = value;
    notifyListeners();
  }
}
