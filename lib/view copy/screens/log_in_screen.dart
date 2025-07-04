import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/gen/assets.gen.dart';
import 'package:tabib_line/service/cache_helper.dart';


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
      emailController.text = CacheHelper.getString(_emailKey) ?? '';
      passwordController.text = CacheHelper.getString(_passwordKey) ?? '';
    }
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

  // void _submit() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     debugPrint('First name: ${firstNameController.text}');
  //     debugPrint('Last name: ${lastNameController.text}');
  //     debugPrint('Email: ${emailController.text}');
  //     debugPrint('Password: ${passwordController.text}');

  //     // may be send to server
  //     // clear after submit
  //     firstNameController.clear();
  //     lastNameController.clear();
  //     emailController.clear();
  //     passwordController.clear();
  //   }
  // }

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

                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       _formKey.currentState!.save();
                        //       debugPrint(
                        //         "First name: ${firstNameController.text}",
                        //       );
                        //       debugPrint(
                        //         "Last name: ${lastNameController.text}",
                        //       );
                        //       debugPrint("Email: ${emailController.text}");
                        //       debugPrint(
                        //         "Password: ${passwordController.text}",
                        //       );
                        //     }
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     minimumSize: const Size.fromHeight(50),
                        //   ),
                        //   child: const Text("Submit"),
                        // ),
                        // const SizedBox(height: 30),
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
                              color: Color(0xFF156651),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          debugPrint("Email: ${emailController.text}");
                          debugPrint("Password: ${passwordController.text}");

                          await CacheHelper.init();
                          if (rememberMe) {
                            await CacheHelper.saveString(
                              _emailKey,
                              emailController.text.trim(),
                            );
                            await CacheHelper.saveString(
                              _passwordKey,
                              passwordController.text.trim(),
                            );
                            await CacheHelper.saveBool(_rememberMeKey, true);
                          } else {
                            await CacheHelper.remove(_emailKey);
                            await CacheHelper.remove(_passwordKey);
                            await CacheHelper.saveBool(_rememberMeKey, false);
                          }
                        }
                        Navigator.pushNamed(context, 'home');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFFFFFFF),
                        backgroundColor: Color(0xFF156651),
                        // side: BorderSide(color: Color(0xFF156651)),
                      ),
                      child: const Text("Log In"),
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
                              color: Color(0xFF156651),
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
}
