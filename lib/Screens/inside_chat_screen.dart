import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/message_model.dart';
import 'package:flutter_application_1/Cubits/chat cubit/chat_cubit.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsideChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverEmail;

  const InsideChatScreen({
    super.key,
    required this.senderId,
    required this.receiverEmail,
  });

  @override
  State<InsideChatScreen> createState() => _InsideChatScreenState();
}

class _InsideChatScreenState extends State<InsideChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<MessageModel> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late ChatCubit _chatCubit;
  StreamSubscription? _chatSubscription;

  @override
  void initState() {
    super.initState();
    _chatCubit = context.read<ChatCubit>();
    _loadMessages();

    // 👇 Register receiveMessages callback ONCE and update only on new messages
    _chatCubit.signalRService.receiveMessages((incomingSenderId, messageText) {
      final msg = MessageModel(
        senderId: incomingSenderId,
        receiverEmail: _chatCubit.senderEmail ?? '',
        message: messageText,
        timestamp: DateTime.now(),
      );

      final isRelated = (msg.receiverEmail == widget.receiverEmail &&
              msg.senderId == widget.senderId) ||
          (msg.receiverEmail == widget.senderId &&
              msg.senderId == widget.receiverEmail);

      if (isRelated) {
        setState(() {
          _messages.add(msg);
          _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        });
        _scrollToBottom();
      }
    });

    _chatSubscription = _chatCubit.stream.listen((state) {
      if (state is ChatMessageSent) {
        final msg = state.message;
        if (msg.receiverEmail == widget.receiverEmail) {
          setState(() {
            _messages.add(msg);
            _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          });
          _scrollToBottom();
        }
      }
    });
  }

  Future<void> _loadMessages() async {
    final fetchedMessages = await _chatCubit.GetMessages(widget.receiverEmail);
    setState(() {
      _messages.clear();
      _messages.addAll(fetchedMessages);
      _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    });
    _scrollToBottom();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _chatCubit.sendMessage(widget.receiverEmail, text);
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      showappbar: true,
      showBackButton: true,
      screenName: widget.receiverEmail,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: _messages.length,
              padding: const EdgeInsets.only(bottom: 10),
              itemBuilder: (_, index) {
                final msg = _messages[_messages.length - 1 - index];
                final isSender = msg.senderId == widget.senderId;

                return Align(
                  alignment:
                      isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSender
                          ? const Color(0xffFED36A)
                          : const Color(0xff455A64),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg.message,
                          style: TextStyle(
                            color: isSender ? Colors.black : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg.timestamp.toLocal().toString().substring(11, 16),
                          style: TextStyle(
                            fontSize: 10,
                            color: isSender ? Colors.black54 : Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: const Color(0xff212832),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Color(0xff6F8793)),
                      filled: true,
                      fillColor: const Color(0xff455A64),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFED36A),
                    foregroundColor: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: _send,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
