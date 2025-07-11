import 'package:flutter/material.dart';
import 'package:pay_bridge/generate_qr_page.dart';
import 'package:pay_bridge/home_page.dart';
import 'package:pay_bridge/splash.dart';
import 'package:pay_bridge/transfer_page.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF107B81), // Use your preferred color
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    routes: {
      "home": (context) => Homepage(),
      "transfer_page": (context) => TransferMoneyPage(),
      "generate_qr_page": (context) => GenerateQrPage(),
    },
  ));
}
