import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/core/utils/globals.dart' as globals;

class CasheHelper {
  static SharedPreferences? sharedPreferences;

  static String? token;
  static String? refreshToken;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static addStringToSP(String key, dynamic value) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (value is int) return await sharedPreferences?.setInt(key, value);
    if (value is bool) return await sharedPreferences?.setBool(key, value);

    return await sharedPreferences?.setDouble(key, value);
  }

  static addBoolToSP(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static dynamic getStringFromSP(String key) async {
    return sharedPreferences?.getString(key);
  }

  static Future<void> removeStringFromSP(String key) async {
    await sharedPreferences?.remove(key);
  }

  static Future<void> loadLocale() async {
    String? locale = await getStringFromSP('locale');
    globals.appLang = locale ?? PlatformDispatcher.instance.locale.languageCode;
  }

  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> addStringToSS(String key, String? value) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String?> getStringFromSS(String key) async {
    return await secureStorage.read(
      key: key,
    );
  }

  static Future<void> removeStringFromSS(String key) async {
    await secureStorage.delete(
      key: key,
    );
  }
}
