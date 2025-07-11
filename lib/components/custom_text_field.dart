import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final border;
  final prefixText;
  final prefixStyle;
  final prefixIcon;
  //final int? maxLines;
  final bool? alignLabelWithHint;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.labelText,
      this.keyboardType,
      this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.border,
      this.prefixText,
      this.prefixStyle,
      this.prefixIcon,
      //  this.maxLines,
      this.alignLabelWithHint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      //    maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: border,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
