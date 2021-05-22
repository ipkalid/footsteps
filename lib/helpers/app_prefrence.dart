import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrence {
  static const USER_UDID = "USERUDID";
  setUdid(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_UDID, value);
  }

  Future<String?> getUdid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_UDID) ?? null;
  }

  static const USER_TOKEN = "USERTOKEN";
  setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TOKEN, value);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_TOKEN) ?? null;
  }

  static const APP_THEME = "APPTHEME";
  setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(APP_THEME, value);
  }

  Future<bool?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(APP_THEME) ?? null;
  }
}
