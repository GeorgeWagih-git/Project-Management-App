import 'package:flutter_application_1/widgets/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Classes/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;

  ChatCubit(this.chatService) : super(ChatInitial());

  Future<void> loadMessages({
    required String token,
    required String receiverId,
  }) async {
    emit(ChatLoading());
    try {
      final messages = await chatService.loadMessages(
        token: token,
        receiverId: receiverId,
      );
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  void sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) {
    chatService.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
    );
  }
}
