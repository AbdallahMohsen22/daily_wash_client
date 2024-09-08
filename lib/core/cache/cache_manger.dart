import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static SharedPreferences? sharedPreferences;
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool contains(String key) {
    return sharedPreferences!.containsKey(key);
  }

  static Future<bool> saveString(String key, dynamic value) async {
    return sharedPreferences!.setString(key, value);
  }

  static Future<bool> remove(String key,) async {
    return sharedPreferences!.remove(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    return sharedPreferences!.setInt(key, value);
  }

  static String? getString(String key, [String? defaultValue]) {
    final value = sharedPreferences!.getString(key);
    return value ?? defaultValue;
  }

  static int? getInt(String key, [int? defaultValue]) {
    final value = sharedPreferences!.getInt(key);
    return value ?? defaultValue;
  }
/*
  static void saveJson(String key, dynamic value) {
    sharedPreferences!.setString(key, jsonEncode(value));
  }

  static dynamic getJson(String key, [dynamic defaultValue]) {
    final value = CacheManager.getString(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return defaultValue;
  }
  */
}
