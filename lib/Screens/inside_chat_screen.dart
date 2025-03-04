import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/Classes/chat_input_field.dart';
import 'package:flutter_application_1/Classes/chat_bubble.dart';

class InsideChatScreen extends StatelessWidget {
  final String name;
  const InsideChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showappbar: true,
      showBackButton: true,
      screenName: "$name",
      child: Column(
        children: [
          Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    ChatBubble(
                      message:
                          "Hi, I'm a design manager from a tech company, I know you from the work on dribbble. Have you got a job?",
                      time: "08:10",
                      isSender: false,
                    ),
                    ChatBubble(
                      message:
                          "Hi sir, I'm not working yet, sir, can someone help me",
                      time: "08:12",
                      isSender: true,
                    ),
                    ChatBubble(
                      message:
                          "Would you like to work in my company, but send your portfolio first",
                      time: "08:14",
                      isSender: false,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                    ChatBubble(
                      message: "Ok sir, I will send",
                      time: "08:16",
                      isSender: true,
                    ),
                  ],
                ),
              ),
              ChatInputField(),
        ],
      ),
    );
  }
}
