import 'package:flutter/material.dart';

class ButtonList extends StatelessWidget {
  final Size size;
  final String title;
  final IconData icon;

  const ButtonList(
      {super.key, required this.size, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF107B81),
            minimumSize: const Size(100, 65),
          ),
          child: Icon(icon, size: size.width * 0.07, color: Colors.white),
        ),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
