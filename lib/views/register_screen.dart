import 'package:flutter/material.dart';
import 'package:pay_bridge/components/custom_text_field.dart';
import 'package:pay_bridge/components/custom_password_field.dart';
import 'package:pay_bridge/components/custom_button.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'package:pay_bridge/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final proofNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cityController = TextEditingController();

  String message = '';
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    proofNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

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
                  autovalidateMode: _autoValidateMode,
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
                              validator: _nameValidator,
                              keyboardType: TextInputType.name,
                              controller: firstNameController,
                              borderRadiusCustom: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Last Name',
                              validator: _nameValidator,
                              keyboardType: TextInputType.name,
                              controller: lastNameController,
                              borderRadiusCustom: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Username',
                        validator: _usernameValidator,
                        controller: usernameController,
                        borderRadiusCustom: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hintText: 'Personal proof number ',
                        validator: _proofValidator,
                        controller: proofNumberController,
                        borderRadiusCustom: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                        controller: emailController,
                        borderRadiusCustom: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: _phoneValidator,
                        controller: phoneController,
                        borderRadiusCustom: BorderRadius.circular(20),
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
                          validator: _confirmPasswordValidator),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hintText: 'City',
                        validator: _cityValidator,
                        controller: cityController,
                        borderRadiusCustom: BorderRadius.circular(20),
                      ),

                      const SizedBox(height: 25),

                      auth.isLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              onPressed: () async {
                                FocusScope.of(context)
                                    .unfocus(); // إغلاق الكيبورد
                                if (_formKey.currentState!.validate()) {
                                  final success = await auth.registerUser(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    username: usernameController.text,
                                    proofNumber: proofNumberController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                    city: cityController.text,
                                  );

                                  setState(() {
                                    message = success
                                        ? 'Registered Successfully'
                                        : auth.error ?? 'Error';
                                  });
                                  if (success) Navigator.pop(context);
                                } else {
                                  setState(() {
                                    _autoValidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),

                      const SizedBox(height: 20),

                      Text(message, style: TextStyle(color: Colors.red)),
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
  // ✅ الاسم الأول والأخير: بين 2 و30 حرفًا
  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$").hasMatch(value.trim())) {
      return 'Only letters allowed';
    }
    if (value.trim().length < 2) return 'Too short';
    if (value.trim().length > 30) return 'Maximum 30 characters allowed';
    return null;
  }

// ✅ اسم المستخدم: 4–20 حرفًا، حروف/أرقام/نقطة/شرطة سفلية
  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (!RegExp(r"^[a-zA-Z0-9._]{4,20}$").hasMatch(value)) {
      return '4–20 characters.\nLetters, numbers, . or _';
    }
    return null;
  }

// ✅ رقم الإثبات: 5–20 حرفًا أو رقمًا (مثلاً رقم هوية)
  String? _proofValidator(String? value) {
    if (value == null || value.isEmpty) return 'Proof number is required';
    if (!RegExp(r"^[A-Z0-9]{5,20}$").hasMatch(value.toUpperCase())) {
      return 'Must be 5–20 letters or numbers';
    }
    return null;
  }

// ✅ البريد الإلكتروني: تنسيق صحيح، ≤ 50 حرفًا
  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final pattern = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!pattern.hasMatch(value.trim())) return 'Invalid email format';
    if (value.length > 50) return 'Maximum 50 characters allowed';
    return null;
  }

// ✅ رقم الجوال: 10 أرقام فقط، يبدأ بـ 05 (مثل السعودية)
  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (!RegExp(r"^05\d{8}$").hasMatch(value)) {
      return 'Enter Saudi 10-digit number (starts with 05)';
    }
    return null;
  }

// ✅ كلمة المرور: ≥ 8 حروف + تحقق من تعقيدها، ≤ 30 حرف
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters';
    if (value.length > 30) return 'Maximum 30 characters allowed';
    final pattern = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])');
    if (!pattern.hasMatch(value)) {
      return 'Include:\n• Uppercase\n• Lowercase\n• Number\n• Symbol';
    }
    return null;
  }

// ✅ تأكيد كلمة المرور
  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

// ✅ المدينة: حروف فقط، ≤ 30 حرف
  String? _cityValidator(String? value) {
    if (value == null || value.isEmpty) return 'City is required';
    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value.trim())) {
      return 'Only letters allowed';
    }
    if (value.length > 30) return 'Maximum 30 characters allowed';
    return null;
  }
}
