import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final bool? alignLabelWithHint;
  final BorderRadius? borderRadiusCustom;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.alignLabelWithHint,
    this.borderRadiusCustom,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = borderRadiusCustom ?? BorderRadius.circular(12);

    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(color: Color(0xFF0C3954)),
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Color(0xFF00A3A3), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2, // يجعل الخطأ أقرب بدون تغليف
        ),
        hintStyle: TextStyle(color: Colors.grey[600]),
        labelStyle: TextStyle(color: Colors.grey[800]),
      ),
    );
  }
}
