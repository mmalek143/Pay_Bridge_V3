import 'package:flutter/material.dart';

class DateDialog extends StatelessWidget {
  final Size size;

  const DateDialog({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.1),
        width: size.width * 0.8,
        height: size.height * 0.4,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 222, 222),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
          ],
        ),
        child: const Center(child: Text("Date Dialog Placeholder")),
      ),
    );
  }
}
