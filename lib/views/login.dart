import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pay_bridge/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import './home_page.dart';
import 'register_screen.dart';
import 'package:pay_bridge/components/custom_text_field.dart';
import 'package:pay_bridge/components/custom_password_field.dart';
import 'package:pay_bridge/components/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/LoginPhoto.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      // Logo
                      Image.asset(
                        "images/whitelogo.png",
                        width: size.width * 1.6,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 140),

                      // Username Field

                      CustomTextField(
                        keyboardType: TextInputType.text,
                        validator: _usernameValidator,
                        hintText: "Username",
                        controller: usernameController,
                        borderRadiusCustom: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      CustomPasswordField(
                        validator: _passwordValidator,
                        hintText: "Password",
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      //يتم تعطيل الزر (onPressed: null)
                      // إذا كانت عملية تسجيل الدخول جارية (auth.isLoading == true) وذلك لتفادي الضغط عليه أكثر من مرة.

                      CustomButton(
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                                FocusScope.of(context).unfocus();

                                // تحقق من صحة النموذج
                                if (!_formKey.currentState!.validate()) return;

                                final success = await auth.login(
                                  usernameController.text,
                                  passwordController.text,
                                );

                                // عرض Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? 'Login successful'
                                          : auth.error ?? 'Login failed',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        success ? Colors.green : Colors.red,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                // إذا تم الدخول بنجاح، انتقل للصفحة الرئيسية
                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const Homepage(),
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                }
                              },
                        child: auth.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),

                      const SizedBox(height: 20),

                      // Register Link
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "YOU DON'T HAVE AN ACCOUNT? | ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const RegisterScreen(),
                                    duration: const Duration(milliseconds: 400),
                                  ),
                                );
                              },
                              child: const Text(
                                "REGISTER NOW",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? _usernameValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Username is required';
  if (value.length > 30) return 'Maximum 30 characters allowed';
  if (!RegExp(r"^[a-zA-Z0-9._]{4,20}$").hasMatch(value)) {
    return 'Use 4–20 letters, numbers, . or _';
  }
  return null;
}

String? _passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Minimum 8 characters required';
  if (value.length > 30) return 'Maximum 30 characters allowed';
  return null;
}
