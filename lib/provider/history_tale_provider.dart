import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  List<Color> _currentGradient = [Colors.blue, Colors.purple];

  List<Color> get currentGradient => _currentGradient;

  void switchGradient() {
    _currentGradient =
        _currentGradient == [Colors.blue, Colors.purple]
            ? [Colors.orange, Colors.red]
            : [Colors.blue, Colors.purple];
    notifyListeners();
  }
}
