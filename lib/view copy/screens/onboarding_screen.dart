import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tabib_line/gen/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<String> paths = [
      Assets.images.onboarding1.path,
      Assets.images.onboarding2.path,
      Assets.images.onboarding3.path,
    ];
    List<String> text1s = [
      'Online Home Store\nand Furniture\n',
      'Delivery Right to Your\nDoorstep\n',
      'Get Support From Our\nSkilled Team\n',
    ];
    // List<String> text2s = [
    //   'Discover all style and budgets of\nfurniture, appliances, kitchen, and more\nfrom 500+ brands in your hand.',
    //   'Sit back, and enjoy the convenience of\nour drivers delivering your\norder to your doorstep.',
    //   'If our products don\'t meet your\nexpectations, we\'re available 24/7 to\nassist you.',
    // ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          buildPageView(
            path: paths[currentIndex],
            text1: text1s[currentIndex],
            // text2: text2s[currentIndex],
          ),
          buildIndicators(),
          const SizedBox(height: 20),
          buildNavigation(context, width),
        ],
      ),
    );
  }

  Column buildNavigation(BuildContext context, double width) {
    return Column(
      children: [
        currentIndex != 0
            ? Row(
                spacing: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (currentIndex != 0) {
                        _pageController.previousPage(
                          duration: Durations.short3,
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF156651), fontSize: 30),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      log(_pageController.page.toString());
                      if (currentIndex != 2) {
                        _pageController.nextPage(
                          duration: Durations.medium4,
                          curve: Easing.linear,
                        );
                      } else if (currentIndex == 2) {
                        Navigator.pushNamed(context, 'log_in');
                      }
                    },
                    child: Ink(
                      width: width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF156651),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    log(_pageController.page.toString());
                    if (currentIndex != 2) {
                      _pageController.nextPage(
                        duration: Durations.medium4,
                        curve: Easing.linear,
                      );
                    }
                  },
                  child: Ink(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF156651),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Row buildIndicators() {
    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          height: 15,
          width: currentIndex == index ? 45 : 15,
          decoration: BoxDecoration(
            color: const Color(0xFF156651),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  SizedBox buildPageView({
    required String path,
    required String text1,
    // required String text2,
  }) {
    return SizedBox(
      height: 630,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        children: List.generate(
          3,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   path,
              //   width: double.infinity,
              //   height: 400,
              //   fit: BoxFit.cover,
              // ),
              ClipPath(
                clipper: BottomOvalClipper(),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 430,
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: text1,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TextSpan(text: text2, style: TextStyle(fontSize: 18)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 50); // go near bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 50, // control point
      size.width,
      size.height - 50, // end point
    );
    path.lineTo(size.width, 0); // top-right
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
