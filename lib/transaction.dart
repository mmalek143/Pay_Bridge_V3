import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  Transaction({super.key});

  TextEditingController datecontroller = TextEditingController();
  String? selectedCurrencyOptions;
  List<String> CurrencyOptions = ["USD", "LYD"];
  String? selectedTransactionOptions;
  List<String> TransactionOptions = [
    "Transfer in",
    "Transfer out",
    "Deposit",
    "withdraw"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Transaction')),
        ),
        body: dateDialog(size, context, context));
  }

  Widget dateDialog(Size size, BuildContext context, setstste) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, size.height - 800, 0, 0),
      child: Center(
        child: Container(
          width: size.width - 80,
          height: size.height / 2.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(255, 227, 222, 222),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 63, 62, 62),
                blurRadius: 7,
                offset: Offset(1, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 8.0),
                child: TextField(
                  controller: datecontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      labelText: " FROM Date "),
                  readOnly: true,
                  onTap: () {
                    firstDate(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 8.0),
                child: TextField(
                  controller: datecontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      labelText: " TO Date "),
                  readOnly: true,
                  onTap: () {
                    firstDate(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: DropdownButtonFormField<String>(
                  value: selectedTransactionOptions,
                  onChanged: (value) {
                    setstste(() {
                      selectedTransactionOptions = value;
                    });
                  },
                  items: TransactionOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: "Transaction Type",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: DropdownButtonFormField<String>(
                  value: selectedCurrencyOptions,
                  onChanged: (value) {
                    setstste(() {
                      selectedCurrencyOptions = value;
                    });
                  },
                  items: CurrencyOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: "Currency Type",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_outlined),
                iconSize: 35.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> firstDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    //  String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    //  datecontroller.text = formattedDate;
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
