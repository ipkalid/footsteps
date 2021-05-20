import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.darkGreen,
    accentColor: AppColor.darkGreen,
    canvasColor: AppColor.white,
    // backgroundColor: Colors.black,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      centerTitle: true,
      elevation: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.superDarkGreen,
      type: BottomNavigationBarType.fixed,
      enableFeedback: false,
      elevation: 6,
      selectedLabelStyle: TextStyle(
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
      ),
    ),
  );
  static var darkTheme = ThemeData();
}
