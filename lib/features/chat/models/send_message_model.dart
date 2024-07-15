class SendMessageModel {
  final String? message;
  final int receiverId;
  final String? image;
  SendMessageModel({
    required this.receiverId,
    this.message,
    this.image,
  });
  Map<String, dynamic> toJson() {
    var map = {
      'receiver_id': receiverId,
      'message': message,
    };
    if (image != null) {
      map['image'] = image;
    }
    return map;
  }
}
