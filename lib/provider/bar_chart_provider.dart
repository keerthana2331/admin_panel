import 'package:flutter/material.dart';

class ChartDataProvider extends ChangeNotifier {
  int selectedYear = 2025;

  void updateYear(int year) {
    selectedYear = year;
    notifyListeners();
  }
}