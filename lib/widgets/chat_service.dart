import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Classes/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatService {
  late HubConnection _connection;
  Function(String senderId, String message)? onMessageReceived;

  // Start SignalR connection
  Future<void> initSignalR(String token) async {
    _connection = HubConnectionBuilder()
        .withUrl(
          'https://frankly-refined-escargot.ngrok-free.app/Hubs/ChatHub',
          HttpConnectionOptions(
            accessTokenFactory: () async => token,
          ),
        )
        .withAutomaticReconnect()
        .build();

    _connection.on('ReceiveMessage', (args) {
      if (args != null && args.length >= 2) {
        final senderId = args[0] as String;
        final message = args[1] as String;
        onMessageReceived?.call(senderId, message);
      }
    });

    await _connection.start();
  }

  // Send a message
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _connection.invoke(
      'SendMessage',
      args: [senderId, receiverId, message],
    );
  }

  // (Optional) Save message locally
  void saveMessageLocally(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final messages = prefs.getStringList('chatMessages') ?? [];
    messages.add(message);
    await prefs.setStringList('chatMessages', messages);
  }

  // Load chat messages from backend API (NOT SignalR hub URL)
  Future<List<MessageModel>> loadMessages({
    required String token,
    required String receiverId,
  }) async {
    final url = Uri.parse(
      'https://frankly-refined-escargot.ngrok-free.app/api/User/GetAllUsers',
    ); // replace with actual endpoint

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages: ${response.body}');
    }
  }
}
