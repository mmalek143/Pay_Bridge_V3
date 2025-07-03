import 'package:flutter/material.dart';

class CustomDialog {
  static Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onOk,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onOk,
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
