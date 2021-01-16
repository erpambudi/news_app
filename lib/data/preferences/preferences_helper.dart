import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  ///Key shared preferences
  static const DARK_THEME = 'DARK_THEME';
  static const DAILY_NEWS = 'DAILY_NEWS';

  ///Mengambil nilai bool dari shared preferences dengan key DARK_THEME
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  ///Menyimpan dan merubah nilai bool ke shared preferences dengan key DARK_THEME
  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }

  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NEWS) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NEWS, value);
  }
}
