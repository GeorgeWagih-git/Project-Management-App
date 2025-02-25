import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showhomebottombar: true,
        showappbar: true,
        showBackButton: false,
        screenName: 'Messeges',
        chatSelected: true,
        child: Center(
          child: Text(
            'Chat Screen in Processing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ));
  }
}
