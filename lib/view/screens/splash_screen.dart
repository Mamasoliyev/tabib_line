import 'package:flutter/material.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // user login bo'lgan
        Navigator.pushReplacementNamed(context, 'navigation');
      } else {
        // user login bo'lmagan
        Navigator.pushReplacementNamed(context, 'onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: 45 * pi / 180,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF254EDB),
                  ),
                ),
              ),
              Assets.images.splashLogo1.svg(height: 100, width: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    'TabibLine',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
