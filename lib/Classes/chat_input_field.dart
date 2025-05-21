import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final void Function(String) onSend;

  const ChatInputField({super.key, required this.onSend});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cannot send empty message."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Color(0xff212832),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Color(0xff6F8793)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xff455A64),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFED36A),
                  foregroundColor: Colors.black,
                ),
                onPressed: _handleSend,
                child: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
