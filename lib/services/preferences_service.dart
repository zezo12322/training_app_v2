import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService._(this._prefs);
  final SharedPreferences _prefs;

  static Future<PreferencesService> instance() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService._(prefs);
  }

  String? getString(String key) => _prefs.getString(key);
  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> set(String key, Object value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else {
      throw ArgumentError('Unsupported preference type for key $key');
    }
  }
}
