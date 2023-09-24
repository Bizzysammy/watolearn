import 'package:flutter/foundation.dart';

class NotificationState with ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }
}

