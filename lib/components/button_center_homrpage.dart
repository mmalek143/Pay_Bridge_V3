import 'package:flutter/material.dart';

class ButtonList extends StatelessWidget {
  final Size size;
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  const ButtonList({
    super.key,
    required this.size,
    required this.title,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final double unit = size.shortestSide * 0.017;

    return Column(
      children: [
        ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF107B81),
            minimumSize: Size(unit * 9, unit * 9), // الزر دائري بحجم مرن
          ),
          child: Icon(
            icon,
            size: unit * 4.2, // حجم الأيقونة مرن
            color: Colors.white,
          ),
        ),
        SizedBox(height: unit * 1.2),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0C3954),
            fontSize: unit * 2, // حجم النص مرن
          ),
        ),
      ],
    );
  }
}
