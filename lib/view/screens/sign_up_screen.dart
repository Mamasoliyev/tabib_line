import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:tabib_line/view/widgets/auth_main_button_widget.dart';

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

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      final pass = passwordController.text;
      setState(() {
        passwordStrength = _getPasswordStrength(pass1: pass);
      });
    });
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
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
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            errors.add('Familiya 2 ta belgidan kam bo‘lmasin');
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
                          color: const Color(0xFF254EDB),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: const Color(0xFF254EDB),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 20),
                Row(
                  children: [
                    MainButton(
                      text: "Create Account",
                      textColor: Colors.white,
                      color: const Color(0xFF254EDB),
                      onPressed: () async {
                        print("bosildi");
                        try {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final firstName = firstNameController.text.trim();
                          final lastName = lastNameController.text.trim();
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                          final userId = userCredential.user?.uid;
                          if (userId != null) {
                            final userDoc = await FirebaseFirestore.instance
                                .collection("users")
                                .doc(userId)
                                .get();
                            if (!userDoc.exists) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .set({
                                    "name": "$firstName $lastName",
                                    "email": email,
                                    "createdAt": FieldValue.serverTimestamp(),
                                  });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Ro'yxatdan o'tish muvaffaqiyatli!",
                                  ),
                                ),
                              );
                            }
                          }
                          Navigator.pushNamed(context, 'log_in');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Bu email ro'yxatdan o'tgan, log in qiling",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message ?? "Xatolik yuz berdi"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                  ],
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

                Row(
                  children: [
                    MainButton(
                      rasm: Assets.images.facebookLogo.svg(),
                      text: "Sign in with Facebook",
                      textColor: Color(0xFF4F73DF),
                      color: const Color(0xFFF9FAFB),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    MainButton(
                      rasm: Assets.images.googleLogo.svg(),
                      text: "Sign in with Google",
                      textColor: Colors.white,
                      color: const Color(0xFF254EDB),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'Already have an account?   ',
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(
                            color: const Color(0xFF254EDB),
                            fontWeight: FontWeight.w900,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, 'log_in'),
                        ),
                      ],
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
