import 'package:flutter/material.dart';

class changePasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextEditingController? oldPasswordController;
  final TextEditingController? newPasswordController;
  final bool obscureText;
  final VoidCallback toggleVisibility;

  const changePasswordField({
    Key? key,
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.toggleVisibility,
    this.oldPasswordController,
    this.newPasswordController,
  }) : super(key: key);

  @override
  _changePasswordFieldState createState() => _changePasswordFieldState();
}

class _changePasswordFieldState extends State<changePasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Color(0xffFED36A)),
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: const Color(0xff455A64),
        suffixIcon: IconButton(
          icon: Icon(
            color: const Color(0xffFED36A),
            widget.obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: widget.toggleVisibility,
        ),
      ),
    );
  }
}
