import 'package:flutter/material.dart';
import 'package:tabib_line/service/cache_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveToCache(mode);
    notifyListeners();
  }

  void _saveToCache(ThemeMode mode) {
    String modeString = 'system';
    if (mode == ThemeMode.light) modeString = 'light';
    if (mode == ThemeMode.dark) modeString = 'dark';
    CacheHelper.saveData(key: 'themeMode', value: modeString);
  }
}
