import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class SimpleDropdown extends StatelessWidget {
  final List<String> items;
  final String? initialItem;
  final onChanged;
  final String hintText;
  final IconData? prefixIcon; // إضافة خاصية للأيقونة

  const SimpleDropdown({
    super.key,
    required this.items,
    this.initialItem,
    this.onChanged,
    this.hintText = 'اختر من القائمة',
    this.prefixIcon, // استقبال الأيقونة
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomDropdown<String>(
        hintText: hintText,
        items: items,
        initialItem: initialItem,
        onChanged: onChanged,
        decoration: CustomDropdownDecoration(
          closedBorder:
              Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
          closedBorderRadius: BorderRadius.circular(12),
          expandedBorder: Border.all(color: const Color(0xFF00A3A3), width: 2),
          expandedBorderRadius: BorderRadius.circular(12),
          closedFillColor: Colors.white,
          expandedFillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white),
          headerStyle: const TextStyle(color: Color(0xFF0C3954)),
          listItemStyle: const TextStyle(color: Color(0xFF0C3954)),
          //  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // إضافة الأيقونة كـ prefixIcon إذا كانت موجودة
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: const Color(0xFF00A3A3),
                )
              : null,
        ),
      ),
    );
  }
}
