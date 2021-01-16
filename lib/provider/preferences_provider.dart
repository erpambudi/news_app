import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/preferences/preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  ///Mengambil data shared prefrences ketika objek PreferencesProvider dibuat
  PreferencesProvider({@required this.preferencesHelper}) {
    _getTheme();
    _getDailyNewsPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyNewsActive = false;
  bool get isDailyNewsActive => _isDailyNewsActive;

  ///getter untuk mengembalikan nilai ThemeData berdasarkan tema yang dipilih.
  ///jika _isDarkTheme true maka mengembalikan tema darkTheme dan sebaliknya
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  ///mengambil nilai bool _isDarkTheme dari class preferencesHelper
  ///kemudian memberitahukan ke ui ada perubahan state(bool)
  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyNewsPreferences() async {
    _isDailyNewsActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  ///fungsi untuk merubah tema berdasarkan parameter value
  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }
}
