import 'package:flutter/material.dart';

class TransactionItem {
  static Widget buildItem({
    required Size size,
    required String type, // 'in' or 'out'
    required String amount,
    required String date,
  }) {
    final double unit = size.shortestSide * 0.02;

    // تحديد القيم بناءً على نوع العملية
    final bool isIn = type == 'in';

    final Color color =
        isIn ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    final String title = isIn ? "TRANSFER IN" : "TRANSFER OUT";
    final IconData icon =
        isIn ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    final Color background =
        isIn ? const Color(0xFFF0FFF4) : const Color(0xFFFFF5F5);
    final double opacity = 0.1;

    return Container(
      margin: EdgeInsets.only(bottom: unit * 1.5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(unit * 1.5),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        /*  boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: unit * 2,
            offset: Offset(0, unit),
          ),
        ], */
      ),
      child: ListTile(
        leading: Container(
          width: unit * 5.5,
          height: unit * 5.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.1),
              ],
            ),
          ),
          child: Icon(icon, color: color, size: unit * 2.2),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0C3954),
            fontSize: unit * 2.2,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: unit * 1.6,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: unit * 1.5, vertical: unit),
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: BorderRadius.circular(unit * 2),
          ),
          child: Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: unit * 1.6,
              color: color,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: unit * 2),
      ),
    );
  }
}
