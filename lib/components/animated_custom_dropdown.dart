import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class SimpleDropdown extends StatelessWidget {
  final List<String> items;
  final onChanged;
  final initialItem;
  const SimpleDropdown(
      {super.key, required this.items, this.onChanged, this.initialItem});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
        hintText: 'Select job role',
        items: items,
        initialItem: initialItem,
        onChanged: onChanged);
  }
}
