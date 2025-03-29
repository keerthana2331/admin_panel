import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  List<List<Color>> gradients = [
    [Colors.blue, Colors.purple],
    [Colors.teal, Colors.green],
    [Colors.orange, Colors.red],
  ];
  
  int _currentIndex = 0;

  List<Color> get currentGradient => gradients[_currentIndex];

  get gradientColors => null;

  void switchGradient() {
    _currentIndex = (_currentIndex + 1) % gradients.length;
    notifyListeners();
  }
}
