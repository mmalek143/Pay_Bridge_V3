import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import './login.dart';
import 'package:pay_bridge/provider/auth_provider.dart';

class ProfilePage extends StatefulWidget {
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  bool biometricEnabled = false;
  String selectedLanguage = 'Arabic';
  String selectedMode = 'Light';
  final AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00A3A3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with User Info
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF00A3A3),
                    Color(0xFF107B81),
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                            color: Colors.white,
                            child: Image.asset("images/profileAvatar.png")),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // User Name
                    Text(
                      widget.customerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // User Email
                    Text(
                      widget.customerEmail,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () => _showEditProfileDialog(),
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF107B81),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Settings Section
            _buildSection(
              title: 'Settings',
              children: [
                _buildSwitchTile(
                  title: 'Notifications',
                  subtitle: 'Receive transaction notices',
                  icon: Icons.notifications_rounded,
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
                _buildTile(
                  title: 'Language',
                  subtitle: selectedLanguage,
                  icon: Icons.language_rounded,
                  onTap: () => _showLanguageDialog(),
                ),
                _buildTile(
                  title: 'Mode',
                  subtitle: selectedMode,
                  icon: Icons.dark_mode,
                  onTap: () => _showModeDialog(),
                ),
              ],
            ),
            // Security Section
            _buildSection(
              title: 'Security and Privacy',
              children: [
                _buildTile(
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  icon: Icons.lock_reset_rounded,
                  onTap: () => _showChangePasswordDialog(),
                ),
                _buildSwitchTile(
                  title: 'Biometric Authentication',
                  subtitle: 'Login with fingerprint or face',
                  icon: Icons.fingerprint_rounded,
                  value: biometricEnabled,
                  onChanged: (value) {
                    setState(() {
                      biometricEnabled = value;
                    });
                  },
                ),
              ],
            ),

            // Support Section
            _buildSection(
              title: 'Help & Support',
              children: [
                _buildTile(
                  title: 'Help Center',
                  subtitle: 'FAQs & Support',
                  icon: Icons.help_center_rounded,
                  onTap: () => _showHelpCenter(),
                ),
                _buildTile(
                  title: 'Contact Support',
                  subtitle: 'Contact our support team',
                  icon: Icons.contact_support_rounded,
                  onTap: () => _showContactSupport(),
                ),
                _buildTile(
                  title: 'Rate App',
                  subtitle: 'Rate your experience',
                  icon: Icons.star_rate_rounded,
                  onTap: () => _showRateApp(),
                ),
                _buildTile(
                  title: 'About',
                  subtitle: 'Information about PayBridge',
                  icon: Icons.info_rounded,
                  onTap: () => _showAboutDialog(),
                ),
              ],
            ),

            // Logout Section
            _buildSection(
              title: '',
              children: [
                _buildTile(
                  title: 'Logout',
                  subtitle: 'Sign out of current account',
                  icon: Icons.logout_rounded,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => _showLogoutDialog(),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C3954),
                ),
              ),
            ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTile({
    required String title,
    String? subtitle,
    required IconData icon,
    Color? iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFF00A3A3)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF00A3A3),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: textColor ?? const Color(0xFF0C3954),
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF00A3A3).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF00A3A3),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF0C3954),
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF00A3A3),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  // Dialog Methods
  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('Edit profile form will be added here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Text('Change password form will be added here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Arabic'),
              value: 'Arabic',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Light'),
              value: 'Light',
              groupValue: selectedMode,
              onChanged: (value) {
                setState(() {
                  selectedMode = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Dark'),
              value: 'Dark',
              groupValue: selectedMode,
              onChanged: (value) {
                setState(() {
                  selectedMode = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpCenter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help Center will open')),
    );
  }

  void _showContactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Support page will open')),
    );
  }

  void _showRateApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('App rating page will open')),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About PayBridge'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PayBridge v1.0.0'),
            SizedBox(height: 10),
            Text('Secure and easy-to-use digital wallet'),
            SizedBox(height: 10),
            Text('© 2025 PayBridge. All rights reserved.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const LoginScreen(),
                  duration: const Duration(milliseconds: 600),
                ),
                (route) => false,
              );
              //  auth.logout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
