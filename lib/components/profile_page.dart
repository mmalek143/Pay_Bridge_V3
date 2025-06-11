import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pay_bridge/login.dart';

class ProfilePage extends StatelessWidget {
  final Size size;
  final String customerName;
  final String customerEmail;

  const ProfilePage({
    super.key,
    required this.size,
    required this.customerName,
    required this.customerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("PROFILE"))),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF107B81),
            height: size.height / 3,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/whitelogo1.png", height: size.height / 7),
                const SizedBox(height: 8),
                Text(customerName,
                    style: const TextStyle(color: Colors.white, fontSize: 22)),
                Text(customerEmail,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(255, 209, 211, 212),
              child: Column(
                children: [
                  _buildTile(
                      "Your Accounts", Icons.account_balance, null, () {}),
                  _buildTile("Edit Profile Name", Icons.edit, null, () {}),
                  _buildTile("Change Password", Icons.lock_reset_outlined, null,
                      () {}),
                  _buildTile("Log Out", Icons.logout, Colors.red, () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const LoginScreen(),
                        duration: Duration(milliseconds: 600),
                      ),
                      (route) => false,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
      String title, IconData icon, Color? color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
