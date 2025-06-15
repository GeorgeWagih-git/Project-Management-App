import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/Classes/home_chat_model.dart';

class SignalRService {
  HubConnection? _hubConnection;
  Function(String senderId, String message)? _onMessageReceived;

  Future<void> init() async {
    final token = await AppPrefs.getToken();
    if (token == null) {
      debugPrint("❌ No token available");
      return;
    }

    _hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://frankly-refined-escargot.ngrok-free.app/Hubs/ChatHub",
          HttpConnectionOptions(
            accessTokenFactory: () async => token,
          ),
        )
        .withAutomaticReconnect()
        .build();

    _hubConnection!.onclose((error) {
      debugPrint("❌ SignalR closed: $error");
    });

    _hubConnection!.on("ReceiveMessage", (arguments) {
      if (arguments == null || arguments.length < 2) return;
      final senderId = arguments[0] as String;
      final message = arguments[1] as String;
      debugPrint("📥 Received from $senderId: $message");

      if (_onMessageReceived != null) {
        _onMessageReceived!(senderId, message);
      }
    });

    _hubConnection!.on("ReceiveChatHome", (arguments) {
      if (arguments == null || arguments.isEmpty) return;
      final rawList = arguments.first as List;
      final chatList = rawList.map((item) {
        final json = Map<String, dynamic>.from(item);
        return HomeChatModel.fromJson(json);
      }).toList();

      _onChatHomeReceived?.call(chatList);
    });

    try {
      await _hubConnection!.start();
      debugPrint("✅ SignalR Connected");
    } catch (e) {
      debugPrint("❌ SignalR start error: $e");
    }
  }

  void receiveMessages(Function(String senderId, String message) onMessage) {
    _onMessageReceived = onMessage;
  }

  void loadChatHome(Function(List<HomeChatModel>) onResult) {
    _onChatHomeReceived = onResult;
    _hubConnection?.invoke("LoadChatHome");
  }

  Future<void> sendMessage(
      String senderId, String receiverEmail, String message) async {
    if (_hubConnection == null ||
        _hubConnection!.state != HubConnectionState.connected) {
      debugPrint("⚠ Cannot send. Not connected.");
      return;
    }

    try {
      await _hubConnection!
          .invoke("SendMessage", args: [senderId, receiverEmail, message]);
      debugPrint("📤 Sent: $message");
    } catch (e) {
      debugPrint("❌ Failed to send message: $e");
    }
  }

  Function(List<HomeChatModel>)? _onChatHomeReceived;

  void dispose() {
    _hubConnection?.stop();
    _hubConnection = null;
    _onMessageReceived = null;
    _onChatHomeReceived = null;
  }
}
