import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  int _notificationCount = 3;

  int get notificationCount => _notificationCount;

  void clearNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }
}
