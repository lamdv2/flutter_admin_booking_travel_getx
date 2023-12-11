import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();

  factory LocalStorageHelper() {
    return _shared;
  }

  late SharedPreferences _preferences;

  static Future<void> initLocalStorageHelper() async {
    _shared._preferences = await SharedPreferences.getInstance();
  }

  static dynamic getValue(String key) {
    return _shared._preferences.get(key);
  }

  static Future<void> setValue(String key, dynamic value) async {
    if (value is int) {
      await _shared._preferences.setInt(key, value);
    } else if (value is double) {
      await _shared._preferences.setDouble(key, value);
    } else if (value is bool) {
      await _shared._preferences.setBool(key, value);
    } else if (value is String) {
      await _shared._preferences.setString(key, value);
    } else if (value is List<String>) {
      await _shared._preferences.setStringList(key, value);
    }
  }

  // save email employee
  static Future<void> setEmail(String value) async {
    await _shared._preferences.setString("emailEmployee", value);
  }

  static String getEmail() {
    return _shared._preferences.getString("emailEmployee") ?? "";
  }

  static Future<void> clearEmail() async {
    String email = _shared._preferences.getString("emailEmployee") ?? "";
    email = "";
    await _shared._preferences.setString("emailEmployee", email);
  }
}
