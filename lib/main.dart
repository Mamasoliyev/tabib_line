import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tabib_line/service/cache_helper.dart';
import 'package:tabib_line/view%20copy/screens/home_screen.dart';
import 'package:tabib_line/view%20copy/screens/log_in_screen.dart';
import 'package:tabib_line/view%20copy/screens/onboarding_screen.dart';
import 'package:tabib_line/view%20copy/screens/sign_up_screen.dart';
import 'package:tabib_line/view%20copy/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tabib_line/firebase_options.dart';

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
    return MaterialApp(
      initialRoute: 'splash',
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
          case 'home':
            return CupertinoPageRoute(builder: (context) => const HomeScreen());
          default:
            return CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
            );
        }
      },
      onUnknownRoute: (settings) =>
          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
