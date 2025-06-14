class HomeChatModel {
  final String email;
  final String latestMessage;
  final DateTime createdAt;

  HomeChatModel({
    required this.email,
    required this.latestMessage,
    required this.createdAt,
  });

  factory HomeChatModel.fromJson(Map<String, dynamic> json) {
    return HomeChatModel(
      email: json['userName'] ?? '',
      latestMessage: json['message'] ?? '',
      createdAt: DateTime.now(),
    );
  }
}
