import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Size size;
  final Color cardColor;

  const CardWidget({super.key, required this.size, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Container(
        width: size.width * 0.8,
        height: size.height / 5,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/whitelogo.png", width: 60),
            const Spacer(),
            const Text("Amount: 15,200 DL",
                style: TextStyle(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Card Holder",
                        style: TextStyle(color: Colors.white70)),
                    Text("Motasem Saklul",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Currency Type",
                        style: TextStyle(color: Colors.white70)),
                    Text("Dinar", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
