import 'package:flutter/material.dart';

class NotificationBox extends StatelessWidget {
  final Size size;

  const NotificationBox({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 2.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                width: size.width,
                height: size.height / 2.25,
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Operation: Transfer In",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Amount: -50 USD", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Time: 12/2/2025 00:12:23",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(187, 211, 206, 206),
            borderRadius: BorderRadius.circular(5),
          ),
          width: size.width,
          height: size.height / 15,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "The 1000 dinars was successfully transferred in 12/AUG/2025",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
