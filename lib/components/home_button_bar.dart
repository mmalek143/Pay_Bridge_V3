import 'package:flutter/material.dart';
import 'button_list.dart';

class HomeButtonBar extends StatelessWidget {
  final Size size;

  const HomeButtonBar({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton("TRANSFER", Icons.arrow_outward),
          _buildButton("GENERATE QR", Icons.qr_code_scanner),
          _buildButton("REQUESTS", Icons.attach_email),
        ],
      ),
    );
  }

  Widget _buildButton(String title, IconData icon) {
    return ButtonList(
      size: size,
      title: title,
      icon: icon,
    );
  }
}
