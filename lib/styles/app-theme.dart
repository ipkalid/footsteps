import 'package:flutter/material.dart';
import 'package:footsteps/styles/app_colors.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.darkGreen,
    accentColor: AppColor.darkGreen,
    // canvasColor: AppColor.white,
    // backgroundColor: Colors.black,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      centerTitle: true,
      elevation: 1,
      textTheme:
          TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 20)),
      //foregroundColor: AppColor.black,
      // titleTextStyle: TextStyle(color: Colors.red),
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

  static var darkTheme = ThemeData(
    //282828
    brightness: Brightness.light,
    primaryColor: AppColor.darkGreen,
    accentColor: AppColor.darkGreen,
    canvasColor: Color(0xff282828),
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
}
