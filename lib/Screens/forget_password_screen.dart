import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            'Forget Screen page is under processing',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
