import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';

void main() {
  runApp(const ProjectManagement());
}

class ProjectManagement extends StatelessWidget {
  const ProjectManagement({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
