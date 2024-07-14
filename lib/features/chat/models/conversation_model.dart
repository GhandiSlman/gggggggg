class ConversationModel {
  final List<Message> messages;

  ConversationModel({required this.messages});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    var list = json['messages'] as List;
    List<Message> messagesList = list.map((i) => Message.fromJson(i)).toList();

    return ConversationModel(messages: messagesList);
  }
}

class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final bool isSender;
  final String message;

  Message({
    this.id = 0,
    this.isSender = true,
    this.senderId = 0,
    required this.receiverId,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      isSender: json['is_sender'] ?? false,
      message: json['message'],
    );
  }

  factory Message.sendFromJson(Map<String, dynamic> map) {
    var json = map['chat'];
    return Message(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      isSender: json['is_sender'] ?? false,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
    };
  }
}
