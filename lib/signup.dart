import 'package:flutter/material.dart';
import 'package:pay_bridge/components/custom_text_field.dart';
import 'package:pay_bridge/components/custom_password_field.dart';
import 'package:pay_bridge/components/custom_button.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('images/LoginPhoto.png'),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Image.asset(
                        "images/whitelogo.png",
                        width: size.width * 0.6,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Create an Account',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      const SizedBox(height: 30),

                      // First & Last Name
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'First Name',
                              validator: _requiredValidator,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Last Name',
                              validator: _requiredValidator,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          if (value.length < 5) {
                            return 'Minimum 5 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: _phoneValidator,
                      ),
                      const SizedBox(height: 15),

                      CustomPasswordField(
                        hintText: 'Password',
                        controller: passwordController,
                        validator: _passwordValidator,
                      ),
                      const SizedBox(height: 15),

                      CustomPasswordField(
                        hintText: 'Confirm Password',
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'City',
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 25),

                      CustomButton(
                        text: 'REGISTER',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registration successful!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
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

  // Validators
  String? _requiredValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Required' : null;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!pattern.hasMatch(value)) return 'Invalid email';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter 10-digit phone number';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters';
    final pattern = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])');
    if (!pattern.hasMatch(value)) {
      return 'Must include:\n• Uppercase\n• Lowercase\n• Number\n• Symbol';
    }
    return null;
  }
}
