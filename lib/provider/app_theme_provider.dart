import 'package:flutter/material.dart';
import 'package:footsteps/helpers/app_prefrence.dart';

class AppThemeProvider with ChangeNotifier {
  AppPrefrence appPrefrence = AppPrefrence();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    appPrefrence.setTheme(value);
    notifyListeners();
  }
}
