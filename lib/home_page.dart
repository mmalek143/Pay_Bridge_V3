import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pay_bridge/components/date_dialog.dart';
import 'package:pay_bridge/home_page_screen.dart';
import 'package:pay_bridge/profile_page.dart';
import 'package:pay_bridge/transaction.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) => setState(() => selectedIndex = index),
        children: [
          HomePageScreen(
            size: size,
          ),
          //  ScanQRPage(),
          DateDialog(size: size),
          Transaction(),
          ProfilePage(
              size: size, customerName: " malek", customerEmail: "malekab@edu"),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(23),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 8,
            activeColor: const Color(0xFF107B81),
            iconSize: 26,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: const Color(0xFF107B81).withOpacity(0.1),
            color: Colors.grey[600],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() => selectedIndex = index);
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: "HOME",
                textColor: const Color(0xFF107B81),
              ),
              GButton(
                icon: Icons.qr_code_2,
                text: "Scan QR",
                textColor: const Color(0xFF107B81),
              ),
              GButton(
                icon: Icons.list_alt,
                text: "Transaction",
                textColor: const Color(0xFF107B81),
              ),
              GButton(
                icon: Icons.person_outlined,
                text: "Profile",
                textColor: const Color(0xFF107B81),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
