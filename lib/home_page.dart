// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pay_bridge/notification.dart';
//import 'package:pay_bridge/login.dart';

import 'package:pay_bridge/components/card_widget.dart';
import 'package:pay_bridge/components/button_list.dart';
import 'package:pay_bridge/components/transaction_tile.dart';
import 'package:pay_bridge/components/date_dialog.dart';
import 'package:pay_bridge/components/profile_page.dart';
//import 'package:pay_bridge/scan_qr_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => setState(() => selectedIndex = index),
        children: [
          buildHomeTab(size),
          //  ScanQRPage(),
          DateDialog(size: size),
          ProfilePage(
              size: size, customerName: " malek", customerEmail: "malekab@edu"),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: GNav(
          gap: 8,
          activeColor: const Color(0xFF107B81),
          tabBackgroundColor: const Color.fromARGB(255, 228, 226, 226),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() => selectedIndex = index);
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          tabs: const [
            GButton(icon: Icons.home_outlined, text: "HOME"),
            GButton(icon: Icons.qr_code_2, text: "Scan QR"),
            GButton(icon: Icons.list_alt, text: "Transaction"),
            GButton(icon: Icons.person_outlined, text: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget buildHomeTab(Size size) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(0, size.height / 14, 0, size.height / 55),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "images/logo1.png",
                height: size.height / 15,
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    size: 30, color: Color(0xFF107B81)),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Notifications(),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          height: size.height / 4,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CardWidget(
                  size: size, cardColor: const Color.fromARGB(255, 31, 69, 64)),
              CardWidget(
                  size: size, cardColor: const Color.fromARGB(255, 82, 11, 11)),
            ],
          ),
        ),
        SizedBox(height: size.height / 40),

        // ✅ استخدام أزرار ButtonList مع title/icon لكل زر
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonList(
              size: size,
              title: "TRANSFER",
              icon: Icons.arrow_outward,
            ),
            ButtonList(
              size: size,
              title: "GENERATE QR",
              icon: Icons.qr_code_scanner,
            ),
            ButtonList(
              size: size,
              title: "REQUESTS",
              icon: Icons.attach_email,
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(top: size.height / 30),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 232, 235),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 97, 97, 97),
                  blurRadius: 8,
                  offset: Offset(4, 4),
                )
              ],
            ),
            height: size.height / 3.2,
            width: size.width / 1.03,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      Text("Last Transactions", style: TextStyle(fontSize: 23)),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      TransactionTile(
                        title: "TRANSFER IN",
                        amount: "-50 USD",
                        date: "12/2/2025 00:12:23",
                      ),
                      TransactionTile(
                        title: "TRANSFER OUT",
                        amount: "-100 USD",
                        date: "15/3/2025 14:30:00",
                      ),
                      TransactionTile(
                        title: "RECEIVED",
                        amount: "+200 USD",
                        date: "20/3/2025 18:00:00",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
