import 'package:flutter/widgets.dart';
import 'package:tabib_line/utils/locale/app_locale.dart';

extension StringExt on String {
  Locale toCustomLocale() {
    switch (this) {
      case "uz-UZ":
        return AppLocales.UZ;
      case "ru-RU":
        return AppLocales.RU;
      case "en-US":
        return AppLocales.EN;
      default:
        return AppLocales.defaultLocale;
    }
  }
}
