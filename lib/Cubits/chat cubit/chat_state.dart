part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatMessageReceived extends ChatState {
  final MessageModel message;

  ChatMessageReceived(this.message);
}

class ChatMessageSent extends ChatState {
  final MessageModel message;

  ChatMessageSent(this.message);
}

class ChatHomeUpdated extends ChatState {
  final Map<String, HomeChatModel> users;
  ChatHomeUpdated(this.users);
}
