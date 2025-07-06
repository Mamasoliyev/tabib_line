import 'dart:ui';

class AppLocales {
  static const Locale UZ = Locale('uz');
  static const Locale RU = Locale('ru');
  static const Locale EN = Locale('en');

  static const List<Locale> supportedLocales = [UZ, RU, EN];
  static Locale defaultLocale = UZ;
}
