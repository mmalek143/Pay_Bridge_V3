import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomPasswordField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      style: const TextStyle(color: Color(0xFF0C3954)),
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF00A3A3), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2, // هذا يجعل الرسالة تظهر تحت الحقل وليس داخله
        ),
        hintStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
    );
  }
}
