import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/chat_bubble.dart';
import 'package:flutter_application_1/Classes/chat_input_field.dart';
import 'package:flutter_application_1/Cubits/chat%20cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

import 'package:flutter_application_1/Classes/user_model.dart';

class InsideChatScreen extends StatefulWidget {
  final String token;
  final String receiverId;

  const InsideChatScreen({
    Key? key,
    required this.token,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<InsideChatScreen> createState() => _InsideChatScreenState();
}

class _InsideChatScreenState extends State<InsideChatScreen> {
  late String senderId;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUserData();
    context.read<ChatCubit>().loadMessages(
          token: widget.token,
          receiverId: widget.receiverId,
        );
  }

  Future<void> loadUserData() async {
    final loadedUser = await AppPrefs.getUser();
    if (loadedUser != null) {
      setState(() {
        user = loadedUser;
        senderId = loadedUser.id;
      });
    }
  }

  void _sendMessage(String text) {
    context.read<ChatCubit>().sendMessage(
          senderId: senderId,
          receiverId: widget.receiverId,
          message: text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      showappbar: true,
      showBackButton: true,
      screenName: user?.userName ?? "Chat",
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is ChatLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return ChatBubble(
                        message: msg.message,
                        time: msg.timestamp,
                        isSender: msg.senderId == senderId,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No messages"));
                }
              },
            ),
          ),
          ChatInputField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
