import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._constructor();
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._constructor();

  final Future<SharedPreferences> _sp = SharedPreferences.getInstance();

  Future<void> remove(String key) async {
    final SharedPreferences prefs = await _sp;
    prefs.remove(key);
  }

  Future<void> setStr(String key, String value) async {
    final SharedPreferences prefs = await _sp;
    prefs.setString(key, value);
  }

  Future<String?> getKey(String key) async {
    final SharedPreferences prefs = await _sp;
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final SharedPreferences prefs = await _sp;
    prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _sp;
    return prefs.getBool(key);
  }

  Future<void> setDouble(String key, double value) async {
    final SharedPreferences prefs = await _sp;
    prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await _sp;
    return prefs.getDouble(key);
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await _sp;
    prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _sp;
    return prefs.getInt(key);
  }

  Future<void> setStrList(String key, List<String> value) async {
    final SharedPreferences prefs = await _sp;
    prefs.setStringList(key, value);
  }

  Future<List<String?>?> getStrList(String key) async {
    final SharedPreferences prefs = await _sp;
    return prefs.getStringList(key);
  }
}
