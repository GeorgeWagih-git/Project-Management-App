import 'dart:convert';

import 'package:flutter_application_1/Classes/home_chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/Classes/message_model.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/chat_service.dart';
import 'package:http/http.dart' as http;

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SignalRService _signalRService;
  String? senderId;
  String? senderEmail;

  final Map<String, List<MessageModel>> _chatHistory = {}; // 🔹 memory store

  ChatCubit(this._signalRService) : super(ChatInitial());

  Future<void> init() async {
    final user = await AppPrefs.getUser();
    if (user == null) return;

    senderId = user.id;
    senderEmail = user.email;

    await _signalRService.init();

    _signalRService.receiveMessages((incomingSenderId, messageText) {
      final message = MessageModel(
        senderId: incomingSenderId,
        receiverEmail: senderEmail ?? '',
        message: messageText,
        timestamp: DateTime.now(),
      );

      final chatPartner = incomingSenderId == senderId
          ? message.receiverEmail
          : incomingSenderId;
      _addMessage(chatPartner, message); // 👈 save it locally
      emit(ChatMessageReceived(message));
    });
  }

  Future<void> sendMessage(String receiverEmail, String content) async {
    if (senderId == null || content.trim().isEmpty) return;

    await _signalRService.sendMessage(senderId!, receiverEmail, content);

    final message = MessageModel(
      senderId: senderId!,
      receiverEmail: receiverEmail,
      message: content,
      timestamp: DateTime.now(),
    );

    _addMessage(receiverEmail, message); // 👈 save sent message
    emit(ChatMessageSent(message));
  }

  void _addMessage(String userEmail, MessageModel message) {
    _chatHistory.putIfAbsent(userEmail, () => []);
    _chatHistory[userEmail]!.add(message);
  }

  Future<List<MessageModel>> _fetchMessages(String receiverEmail) async {
    final token = await AppPrefs.getToken();
    final url = Uri.parse(
        'https://frankly-refined-escargot.ngrok-free.app/api/User/GetMessages/$receiverEmail');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) {
        return MessageModel(
          senderId: jsonItem['senderId'],
          receiverEmail: jsonItem['receiverId'],
          message: jsonItem['message'],
          timestamp: DateTime.parse(jsonItem['createdAt']),
        );
      }).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<MessageModel>> GetMessages(String userEmail) async {
    if (_chatHistory.containsKey(userEmail)) {
      return _chatHistory[userEmail]!;
    }

    try {
      final fetchedMessages = await _fetchMessages(userEmail);
      _chatHistory[userEmail] = fetchedMessages;
      return fetchedMessages;
    } catch (e) {
      print("❌ Error fetching messages: $e");
      return [];
    }
  }

  void loadChatHome(Function(List<HomeChatModel>) onData) {
    _signalRService.loadChatHome(onData);
  }

  void dispose() {
    _signalRService.dispose();
  }
}
