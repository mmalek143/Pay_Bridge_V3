import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay_bridge/provider/auth_provider.dart';
import 'package:pay_bridge/views/generate_qr_page.dart';
import 'package:pay_bridge/views/home_page.dart';
import 'package:pay_bridge/views/splash.dart';
import 'package:pay_bridge/views/transfer_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF107B81),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        "home": (context) => const Homepage(),
        "transfer_page": (context) => const TransferMoneyPage(),
        "generate_qr_page": (context) => const GenerateQrPage(),
      },
    );
  }
}
