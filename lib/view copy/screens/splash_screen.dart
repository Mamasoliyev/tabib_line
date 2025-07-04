import 'package:flutter/material.dart';
import 'package:tabib_line/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, 'onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: 30 * 3.1415926535 / 180,

        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 40, height: 40, color: Color(0xFF254EDB)),
                Positioned(
                  bottom: 50,
                  child: Text(
                    'TabibLine',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                Assets.images.splashLogo1.svg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  // Assets.images.splashLogo1.svg(),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 'TabibLine',
  //                 style: TextStyle(
  //                   fontSize: 40,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                   fontFamily: 'Nunito',
  //                 ),
