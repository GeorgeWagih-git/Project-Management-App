import 'package:flutter/material.dart';

class BuildNavItem extends StatelessWidget {
  const BuildNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Color(0xffFED36A) : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Color(0xffFED36A) : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
