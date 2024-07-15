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
  bool isSending;
  final String? message;
  String? image;

  Message({
    this.id = 0,
    this.isSender = true,
    this.isSending = false,
    this.senderId = 0,
    required this.receiverId,
    this.message,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    bool isImage = json['message'].toString().contains('ChatMessageImages');
    return Message(
      id: json['id'] ?? 0,
      receiverId: int.parse(json['receiver_id'].toString()),
      senderId: int.parse(json['sender_id'].toString()),
      isSender: json['is_sender'] ?? false,
      message: isImage ? null : json['message'],
      image: !isImage ? null : json['message'],
    );
  }

  factory Message.sendFromJson(Map<String, dynamic> map) {
    var json = map['chat'];
    bool isImage = json['message'].toString().contains('ChatMessageImages');
    return Message(
      id: json['id'] ?? 0,
      receiverId: int.parse(json['receiver_id'].toString()),
      senderId: int.parse(json['sender_id'].toString()),
      isSender: json['is_sender'] ?? false,
      message: isImage ? null : json['message'],
      image: !isImage ? null : json['message'],
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
