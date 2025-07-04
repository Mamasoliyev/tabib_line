// import 'package:shared_preferences/shared_preferences.dart';

// class CacheHelper {
//   static SharedPreferences? _preferences;

//   static final CacheHelper _instance = CacheHelper._internal();

//   CacheHelper._internal();

//   factory CacheHelper() => _instance;

//   static Future<void> init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future<void> saveString(String key, String value) async {
//     await _preferences?.setString(key, value);
//   }

//   static String? getString(String key) {
//     return _preferences?.getString(key);
//   }

//   static Future<void> remove(String key) async {
//     await _preferences?.remove(key);
//   }

//   static Future<void> clear() async {
//     await _preferences?.clear();
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }
}
