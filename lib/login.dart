import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pay_bridge/home_page.dart';
import 'package:pay_bridge/signup.dart';
import 'package:pay_bridge/components/custom_text_field.dart';
import 'package:pay_bridge/components/custom_password_field.dart';
import 'package:pay_bridge/components/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    const CustomTextField(
                      hintText: "USERNAME",
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    CustomPasswordField(
                      hintText: "Password",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    CustomButton(
                      text: "LOGIN",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Homepage(),
                            duration: const Duration(milliseconds: 600),
                          ),
                        );
                      },
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
                                    duration: Duration(milliseconds: 400),
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
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
