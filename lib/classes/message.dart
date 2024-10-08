class Message {
  String sender = '';
  String message = '';

  Message({required this.sender, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json["sender"] as String,
      message: json["message"] as String,
    );
  }
}
