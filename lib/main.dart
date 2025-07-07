import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tabib_line/service/cache_helper.dart';
import 'package:tabib_line/view/screens/admin_screen.dart';
import 'package:tabib_line/view/screens/navigation_screen.dart';
import 'package:tabib_line/view/screens/log_in_screen.dart';
import 'package:tabib_line/view/screens/onboarding_screen.dart';
import 'package:tabib_line/view/screens/sign_up_screen.dart';
import 'package:tabib_line/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tabib_line/firebase_options.dart';
import 'package:tabib_line/view_model/buttom_navigation_provider.dart';
import 'package:tabib_line/view_model/theme_provider.dart';
import 'package:tabib_line/view_model/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  String? savedTheme = CacheHelper.getData(key: 'themeMode');
  ThemeMode initialThemeMode = ThemeMode.system;

  if (savedTheme == 'light') {
    initialThemeMode = ThemeMode.light;
  } else if (savedTheme == 'dark') {
    initialThemeMode = ThemeMode.dark;
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uz'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ButtomNavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(initialThemeMode),
          ),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: const Color(0xFF020E22),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF020E22),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: const ColorScheme.dark().copyWith(primary: Colors.blue),
      ),
      themeMode: themeProvider.themeMode,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'splash':
            return CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
            );
          case 'log_in':
            return CupertinoPageRoute(
              builder: (context) => const LogInScreen(),
            );
          case 'sign_up':
            return CupertinoPageRoute(
              builder: (context) => const SignUpScreen(),
            );
          case 'onboarding':
            return CupertinoPageRoute(
              builder: (context) => const OnboardingScreen(),
            );
          case 'navigation':
            return CupertinoPageRoute(
              builder: (context) => const NavigationScreen(),
            );
          case 'admin':
            return CupertinoPageRoute(
              builder: (context) => const AdminPanelScreen(),
            );
          default:
            return CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
            );
        }
      },
      onUnknownRoute: (settings) =>
          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
