import 'package:flutter/material.dart';

Widget buildEditableTextField(String label, TextEditingController controller,
    bool obscureText, bool isEditing) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      enabled: isEditing,
      style: TextStyle(color: isEditing ? Color(0xffFED36A) : Colors.grey),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Color(0xff455A64),
        suffixIcon: obscureText ? Icon(Icons.visibility_off) : null,
      ),
    ),
  );
}
