import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showhomebottombar: true,
        calenderSelected: true,
        showappbar: true,
        showBackButton: false,
        screenName: 'Schedule',
        child: Center(
          child: Text(
            'Calender Screen in Processing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ));
  }
}
