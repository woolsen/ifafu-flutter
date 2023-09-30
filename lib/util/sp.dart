import 'package:shared_preferences/shared_preferences.dart' as sp;

class SPUtil {
  static SPUtil _instance = SPUtil._internal();
  static sp.SharedPreferences? _preferences;

  // 私有构造函数，确保单例模式
  SPUtil._internal();

  // 获取SharedPreferencesUtil单例
  factory SPUtil() {
    return _instance;
  }

  // 初始化SharedPreferences
  static Future<void> ensureInitialized() async {
    if (_preferences != null) return;
    _preferences = await sp.SharedPreferences.getInstance();
  }

  // 保存数据到SharedPreferences
  static Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  // 从SharedPreferences读取数据
  static String? getString(String key) {
    return _preferences!.getString(key);
  }

  // 保存数据到SharedPreferences
  static Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  // 从SharedPreferences读取数据
  static int? getInt(String key) {
    return _preferences!.getInt(key);
  }

  // 保存数据到SharedPreferences
  static Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  // 从SharedPreferences读取数据
  static double? getDouble(String key) {
    return _preferences!.getDouble(key);
  }

  // 保存数据到SharedPreferences
  static Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  // 从SharedPreferences读取数据
  static bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  // 保存数据到SharedPreferences
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  // 从SharedPreferences读取数据
  static List<String>? getStringList(String key) {
    return _preferences!.getStringList(key);
  }

  // 删除SharedPreferences中的数据
  static Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  // 清空SharedPreferences中的所有数据
  static Future<bool> clear() async {
    return await _preferences!.clear();
  }
}
