import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Size size;
  final int cardIndex;
  final double amount;
  final String cardHolder;
  final String currencyType;

  const CardWidget({
    super.key,
    required this.size,
    required this.cardIndex,
    required this.amount,
    required this.cardHolder,
    required this.currencyType,
  });

  @override
  Widget build(BuildContext context) {
    final double unit = size.shortestSide * 0.02;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: unit * 1.5, vertical: unit),
      padding: EdgeInsets.all(unit * 3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: unit * 0.6,
            offset: Offset(0, unit * 0.3),
          )
        ],
        borderRadius: BorderRadius.circular(unit * 2),
        image: const DecorationImage(
          image: AssetImage("images/cardPy.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///  بيانات المبلغ واسم حامل البطاقة
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Amount",
                style: TextStyle(
                  fontSize: unit * 2,
                  color: const Color.fromARGB(150, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$amount",
                style: TextStyle(
                  fontSize: unit * 2.9,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(12, 57, 84, 1.0),
                ),
              ),
              SizedBox(height: unit * 1),
              Text(
                "Card Holder",
                style: TextStyle(
                  fontSize: unit * 2,
                  color: const Color.fromARGB(150, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                cardHolder,
                style: TextStyle(
                  fontSize: unit * 2.7,
                  color: const Color.fromRGBO(12, 57, 84, 1.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          /// 💱 نوع العملة
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Currency Type",
                style: TextStyle(
                  fontSize: unit * 2,
                  color: const Color.fromARGB(150, 30, 30, 30),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                currencyType,
                style: TextStyle(
                  fontSize: unit * 2.7,
                  color: const Color.fromRGBO(12, 57, 84, 1.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
