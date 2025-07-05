import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:tabib_line/service/cache_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = true;
  bool isVisible = false;
  bool rememberMe = false;

  String passwordStrength = "";
  bool firstNameValid = false;
  bool lastNameValid = false;
  bool emailValid = false;
  bool isLogin = false;

  static const String _firstNameKey = "firstName";
  static const String _lastNameKey = "lastName";
  static const String _emailKey = "email";
  static const String _passwordKey = "password";
  static const String _rememberMeKey = "rememberMe";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      await _loadSavedData();
      setState(() {
        isLoading = false;
      });
    });
    passwordController.addListener(() {
      final pass = passwordController.text;
      setState(() {
        passwordStrength = _getPasswordStrength(pass1: pass);
      });
    });
  }

  Future<void> _loadSavedData() async {
    await CacheHelper.init();
    rememberMe = CacheHelper.getBool(_rememberMeKey) ?? false;

    if (rememberMe) {
      firstNameController.text = CacheHelper.getString(_firstNameKey) ?? '';
      lastNameController.text = CacheHelper.getString(_lastNameKey) ?? '';
      emailController.text = CacheHelper.getString(_emailKey) ?? '';
      passwordController.text = CacheHelper.getString(_passwordKey) ?? '';
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _getPasswordStrength({required String pass1}) {
    if (pass1.length < 6) return "Kuchsiz";
    if (pass1.length < 10) return "O‘rtacha";
    return "Kuchli";
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                // bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Fill in your details below to get started on a seamless shopping experience.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  // First Name
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First name
                        TextFormField(
                          controller: firstNameController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "First name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixIcon: firstNameValid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            final trimmed = value.trim();
                            bool valid = RegExp(
                              r"^[a-zA-Zа-яА-ЯёЁўғқҳҲҚЎҒ\s]+$",
                            ).hasMatch(trimmed);
                            setState(() {
                              firstNameValid =
                                  trimmed.isNotEmpty &&
                                  trimmed.length >= 2 &&
                                  valid;
                            });
                          },
                          validator: (value) {
                            final trimmed = value?.trim() ?? '';
                            List<String> errors = [];
                            if (trimmed.isEmpty) {
                              errors.add('Ism kiritilishi shart');
                            }
                            if (trimmed.length < 2) {
                              errors.add('Ism 2 ta belgidan kam bo‘lmasin');
                            }
                            if (!RegExp(
                              r"^[a-zA-Zа-яА-ЯёЁўғқҳҲҚЎҒ\s]+$",
                            ).hasMatch(trimmed)) {
                              errors.add('Faqat harflar ruxsat etiladi');
                            }
                            if (errors.isEmpty) return null;
                            return errors.join('\n');
                          },
                        ),

                        const SizedBox(height: 16),

                        // Last name
                        TextFormField(
                          controller: lastNameController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Last name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixIcon: lastNameValid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            final trimmed = value.trim();
                            bool valid = RegExp(
                              r"^[a-zA-Zа-яА-ЯёЁўғқҳҲҚЎҒ\s]+$",
                            ).hasMatch(trimmed);
                            setState(() {
                              lastNameValid =
                                  trimmed.isNotEmpty &&
                                  trimmed.length >= 2 &&
                                  valid;
                            });
                          },
                          validator: (value) {
                            final trimmed = value?.trim() ?? '';
                            List<String> errors = [];
                            if (trimmed.isEmpty) {
                              errors.add('Familiya kiritilishi shart');
                            }
                            if (trimmed.length < 2) {
                              errors.add(
                                'Familiya 2 ta belgidan kam bo‘lmasin',
                              );
                            }
                            if (!RegExp(
                              r"^[a-zA-Zа-яА-ЯёЁўғқҳҲҚЎҒ\s]+$",
                            ).hasMatch(trimmed)) {
                              errors.add('Faqat harflar ruxsat etiladi');
                            }
                            if (errors.isEmpty) return null;
                            return errors.join('\n');
                          },
                        ),

                        const SizedBox(height: 16),

                        // Email
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            labelText: "Email",
                            suffixIcon: emailValid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) {
                            final trimmed = value.trim();
                            bool valid = RegExp(
                              r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$",
                            ).hasMatch(trimmed);
                            setState(() {
                              emailValid =
                                  trimmed.isNotEmpty &&
                                  trimmed.length >= 2 &&
                                  valid;
                            });
                          },

                          validator: (value) {
                            final trimmed = value?.trim() ?? '';
                            if (trimmed.isEmpty) {
                              return 'Email kiritilishi shart';
                            }
                            if (!RegExp(
                              r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$",
                            ).hasMatch(trimmed)) {
                              return 'Noto‘g‘ri email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Password
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            final trimmed = value?.trim() ?? '';
                            if (trimmed.isEmpty) {
                              return 'Parol kiritilishi shart';
                            }
                            if (trimmed.length < 6) {
                              return 'Kamida 6 belgi bo‘lsin';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 6),

                        // password kuchi ko‘rsatkich
                        Text(
                          passwordStrength,
                          style: TextStyle(
                            color: passwordStrength == "Kuchli"
                                ? Colors.green
                                : (passwordStrength == "O‘rtacha"
                                      ? Colors.orange
                                      : Colors.red),
                          ),
                        ),

                        // const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Remember me'),

                            Switch(
                              value: rememberMe,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                      ],
                    ),
                  ),

                  Text.rich(
                    TextSpan(
                      text:
                          "By clicking Create Account, you acknowledge you have read and agreed to our ",
                      children: [
                        TextSpan(
                          text: "Terms of Use",
                          style: TextStyle(
                            color: Color(0xFF156651),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Color(0xFF156651),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        print("bosildi");
                        try {
                          if (isLogin) {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          } else {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                                  "name":
                                      firstNameController.text.trim() +
                                      ' ' +
                                      lastNameController.text.trim(),
                                  "email": emailController.text.trim(),
                                });
                            log(userCredential.toString());
                            log(userCredential.user?.uid.toString() ?? '');
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFFFFFFF),
                        backgroundColor: Color(0xFF156651),
                        // side: BorderSide(color: Color(0xFF156651)),
                      ),
                      child: const Text("Create Account"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Assets.images.googleLogo.svg(),
                      label: const Text("Continue with Google"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF156651),
                        side: BorderSide(color: Color(0xFF156651)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Assets.images.facebookLogo.svg(),
                      label: const Text("Continue with Facebook"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF156651),
                        side: BorderSide(color: Color(0xFF156651)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
