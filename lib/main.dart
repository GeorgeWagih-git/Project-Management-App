import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import './Classes/task_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskModel()),
        ChangeNotifierProvider(create: (context) => ProjectModel()),
      ],
      child: ProjectManagement(),
    ),
  );
}

class ProjectManagement extends StatelessWidget {
  const ProjectManagement({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
