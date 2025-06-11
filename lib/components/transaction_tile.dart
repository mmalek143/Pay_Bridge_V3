import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String amount;
  final String date;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        height: size.height / 15,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 214, 216, 218),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.call_received),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                Text(date, style: const TextStyle(fontSize: 12)),
              ],
            ),
            Text(amount, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
