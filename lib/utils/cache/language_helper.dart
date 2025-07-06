import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static LanguageHelper instance = LanguageHelper._internal();

  LanguageHelper._internal();

  factory LanguageHelper() {
    return instance;
  }

  late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> cacheLan(Locale locale) async {
    await preferences.setString(
      "language",
      "${locale.languageCode}-${locale.countryCode}",
    );
  }

  String getLan() {
    return preferences.getString("language") ?? "uz-UZ";
  }
}
