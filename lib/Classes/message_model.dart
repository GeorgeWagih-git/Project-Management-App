class MessageModel {
  final String senderId;
  final String receiverEmail;
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.receiverEmail,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverEmail: json['receiverEmail'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}