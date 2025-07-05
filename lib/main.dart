import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tabib_line/service/cache_helper.dart';
import 'package:tabib_line/view/screens/navigation_screen.dart';
import 'package:tabib_line/view/screens/log_in_screen.dart';
import 'package:tabib_line/view/screens/onboarding_screen.dart';
import 'package:tabib_line/view/screens/sign_up_screen.dart';
import 'package:tabib_line/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tabib_line/firebase_options.dart';
import 'package:tabib_line/view_model/buttom_navigation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ButtomNavigationProvider(),
      child: MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Nunito',
          // scaffoldBackgroundColor: Colors.white,
          // textTheme: const TextTheme(
          //   bodyLarge: TextStyle(color: Colors.white),
          //   bodyMedium: TextStyle(color: Colors.black),
          //   bodySmall: TextStyle(color: Colors.white),
          //   titleLarge: TextStyle(color: Colors.white),
          // ),
          // cupertinoOverrideTheme: const CupertinoThemeData(
          //   brightness: Brightness.light,
          //   scaffoldBackgroundColor: Colors.white,
          //   textTheme: CupertinoTextThemeData(
          //     textStyle: TextStyle(color: Colors.white, fontFamily: 'Nunito'),
          //   ),
          // ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Nunito',
          // scaffoldBackgroundColor: Colors.black,
          // textTheme: const TextTheme(
          //   bodyLarge: TextStyle(color: Colors.white),
          //   bodyMedium: TextStyle(color: Colors.black),
          //   bodySmall: TextStyle(color: Colors.white),
          //   titleLarge: TextStyle(color: Colors.white),
          // ),
          // cupertinoOverrideTheme: const CupertinoThemeData(
          //   brightness: Brightness.dark,
          //   scaffoldBackgroundColor: Colors.black,
          //   textTheme: CupertinoTextThemeData(
          //     textStyle: TextStyle(color: Colors.white, fontFamily: 'Nunito'),
          //   ),
          // ),
        ),

        // themeMode: ThemeMode.system,
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
            case '/':
              return CupertinoPageRoute(
                builder: (context) => const NavigationScreen(),
              );
            default:
              return CupertinoPageRoute(
                builder: (context) => const SplashScreen(),
              );
          }
        },
        onUnknownRoute: (settings) =>
            CupertinoPageRoute(builder: (context) => const SignUpScreen()),
      ),
    );
  }
}
