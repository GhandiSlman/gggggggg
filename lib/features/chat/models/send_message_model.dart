class SendMessageModel {
  final String message;
  final int receiverId;
  SendMessageModel({
    required this.message,
    required this.receiverId,
  });
  Map toJson() {
    return {
      'receiver_id': receiverId,
      'message': message,
    };
  }
}
