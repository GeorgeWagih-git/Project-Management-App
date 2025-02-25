import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showhomebottombar: true,
        notificationSelected: true,
        showappbar: true,
        showBackButton: false,
        screenName: 'Notfications',
        child: Center(
          child: Text(
            'Notfications Screen in Processing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ));
  }
}
