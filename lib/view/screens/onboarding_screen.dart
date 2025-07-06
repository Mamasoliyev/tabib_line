import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:tabib_line/view/widgets/auth_main_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  String _selectedLanguage = 'O‘zbek tili';

  final List<String> images = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
  ];
  final List<String> text1 = [
    "Welcome",
    "Choose Specialization",
    "Schedule Your First Appointment",
  ];

  final List<String> text2 = [
    "We will assist you in efficiently and easily scheduling appointments with doctors. Let’s get started!",
    "Select the medical specialization you need so we can tailor your experience.",
    "Choose a suitable time and date to meet your preferred doctor. Begin your journey to better health!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EBF5),
      body: SafeArea(
        child: Stack(
          children: [
            // til tanlash o‘ng yuqori
            Positioned(
              right: 16,
              top: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    items: ['O‘zbek tili', 'Ingliz tili', 'Rus tili'].map((
                      lang,
                    ) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedLanguage = val;
                        });
                      }
                    },
                    icon: const Icon(Icons.language),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                // Rasm qismi
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(images[index], fit: BoxFit.contain),
                      );
                    },
                  ),
                ),

                // indikator — QOTGAN holatda
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (dotIndex) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: _currentIndex == dotIndex
                              ? Colors.blue
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // matn
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          text1[_currentIndex],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          text2[_currentIndex],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            MainButton(
                              text: "Skip",
                              textColor: Colors.black,
                              color: const Color(0xFFF9FAFB),
                              onPressed: () {
                                // Masalan: oxirgi sahifaga sakrash
                                _pageController.jumpToPage(images.length - 1);
                              },
                            ),

                            const SizedBox(width: 16),
                            MainButton(
                              text: "Next",
                              textColor: Colors.white,
                              color: const Color(0xFF254EDB),
                              onPressed: () {
                                if (_currentIndex < images.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Navigator.pushNamed(context, 'log_in');
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
