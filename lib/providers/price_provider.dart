import 'package:flutter/material.dart';

class PriceProvider extends ChangeNotifier {
  late String _calculatedPrice;

  String get calculatedPrice => _calculatedPrice;

  void setCalculatedPrice(String price) {
    _calculatedPrice = price;
    notifyListeners();
  }
}