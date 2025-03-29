import 'package:flutter/material.dart';

class PaymentTileProvider with ChangeNotifier {
  bool isTapped = false;

  void toggleTap() {
    isTapped = !isTapped;
    notifyListeners();
  }
}