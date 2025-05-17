import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;

  ChatBubble({required this.message, required this.time, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSender) CircleAvatar(backgroundImage: AssetImage('assets/person.png'),radius: 18),
        SizedBox(width: 8),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isSender ? Color(0xffFED36A): Color(0xff455A64),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: TextStyle(color: isSender ? Colors.black : Colors.white)),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(time, style: TextStyle(fontSize: 10, color: isSender ? Colors.black : Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}