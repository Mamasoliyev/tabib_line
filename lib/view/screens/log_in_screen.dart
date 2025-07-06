import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:tabib_line/service/cache_helper.dart';
import 'package:tabib_line/view/widgets/auth_main_button_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = true;
  bool rememberMe = false;
  bool isVisible = false;

  String passwordStrength = "";
  bool emailValid = false;

  static const String _emailKey = "email";
  static const String _passwordKey = "password";
  static const String _rememberMeKey = "rememberMe";

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
                  "Welcome Back!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter your email to start shopping and get\nawesome deals today!",
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Forgot your password?",
                          style: TextStyle(
                            color: const Color(0xFF254EDB),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    MainButton(
                      text: "Log In",
                      textColor: Colors.white,

                      color: const Color(0xFF254EDB),

                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            // firebase auth orqali tekshirish
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                            // agar admin bo'lsa
                            if (email == "nodirbek7@gmail.com" &&
                                password == "nodirbek") {
                              Navigator.pushNamed(context, 'admin');
                            } else {
                              Navigator.pushNamed(context, 'navigation');
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Bunday foydalanuvchi mavjud emas, iltimos ro'yxatdan o'ting",
                                  ),
                                ),
                              );
                            } else {
                              // boshqa firebase xatoliklari
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.message ?? "Xatolik yuz berdi",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
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
                      // rasm: Assets.i,
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

                      onPressed: () {
                        // Masalan: oxirgi sahifaga sakrash
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'Don\'t have your account?  ',
                      children: [
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: const Color(0xFF254EDB),
                            fontWeight: FontWeight.w900,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, 'sign_up'),
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
