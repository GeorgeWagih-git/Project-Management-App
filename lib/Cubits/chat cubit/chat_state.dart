part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;

  ChatLoaded({required this.messages});
}

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}
