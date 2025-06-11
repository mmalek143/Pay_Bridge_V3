import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Transaction')),
      ),
      body: ListView.builder(
        itemCount: 20, // أو استخدم قائمة بيانات حقيقية
        itemBuilder: (context, index) {
          return TransactionTile(
            size: size,
            title: "TRANSFER IN",
            amount: "-50 USD",
            date: "12/2/2025 00:12:23",
          );
        },
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Size size;
  final String title;
  final String amount;
  final String date;

  const TransactionTile({
    super.key,
    required this.size,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
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
