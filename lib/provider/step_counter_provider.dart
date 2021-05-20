import 'package:flutter/material.dart';

class StepCounterProvider with ChangeNotifier {
  String _status = '?';
  String get status => _status;
  set status(String value) {
    _status = value;
    notifyListeners();
  }

  String _steps = '?';
  String get steps => _status;
  set steps(String value) {
    _status = value;
    notifyListeners();
  }
}
