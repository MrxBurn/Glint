import 'package:glint/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatExists {
  String existingChatId;
  String user1;
  String user2;

  ChatExists(
      {required this.existingChatId, required this.user1, required this.user2});

  factory ChatExists.fromJson(Map<String, dynamic> json) {
    return ChatExists(
      existingChatId: json["existing_chat_id"] as String,
      user1: json["user1"] as String,
      user2: json["user2"],
    );
  }
}

Future<Map<String, dynamic>> getUserFromChat(
    Map<String, dynamic> existingChat, UserClass currentUser) async {
  final userLogic = currentUser.id == existingChat['user1']
      ? existingChat['user2']
      : existingChat['user1'];

  final userFromChat =
      await Supabase.instance.client.from('users').select().eq('id', userLogic);

  return userFromChat[0];
}
