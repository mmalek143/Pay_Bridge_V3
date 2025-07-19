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

  CustomTextField({
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // زيادة وضوح الظل
            spreadRadius: 2, // زيادة انتشار الظل
            blurRadius: 8, // زيادة تمويه الظل
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFF0C3954)), // لون النص المدخل
        decoration: InputDecoration(
          alignLabelWithHint: alignLabelWithHint,
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          filled: true,
          fillColor:
              Colors.grey[100], // لون خلفية حقل الإدخال لجعله أكثر بروزًا
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1), // إضافة حدود خفيفة
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1), // إضافة حدود خفيفة
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
                color: Color(0xFF00A3A3), width: 2), // حدود عند التركيز
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey[600]), // لون النص التلميحي
          labelStyle: TextStyle(color: Colors.grey[800]), // لون نص التسمية
        ),
      ),
    );
  }
}
