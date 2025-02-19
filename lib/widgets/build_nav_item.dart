import 'package:flutter/material.dart';

class BuildNavItem extends StatelessWidget {
  const BuildNavItem(
      {required this.icon,
      required this.label,
      required this.isSelected,
      super.key});
  final IconData icon; // تعريف المتغيرات
  final String label;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon ?? Icons.clear,
            color: isSelected ? Colors.white : Colors.grey),
        Text(
          label!,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
