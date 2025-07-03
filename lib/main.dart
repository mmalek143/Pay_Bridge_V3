import 'package:flutter/material.dart';
import 'package:pay_bridge/home_page.dart';
import 'package:pay_bridge/splash.dart';
import 'package:pay_bridge/transfer_page.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: {
      "home": (context) => Homepage(),
      "transfer_page": (context) => TransferMoneyPage()
    },
  ));
}
