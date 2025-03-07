import 'package:glint/models/isChatting.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'message.g.dart';

class Message {
  String sender = '';
  String message = '';
  String? createdAt;

  Message({required this.sender, required this.message, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json["sender"] as String,
      message: json["message"] as String,
      createdAt: json["created_at"],
    );
  }
}

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late UserClass? user;

  late Map<String, dynamic>? matchedUser;

  @override
  Stream<List<Message>> build() {
    user = ref.watch(userNotifierProvider).value;
    matchedUser = ref.watch(fetchMatchedUsersProvider).value;
    return streamMessages();
  }

  Stream<List<Message>> streamMessages() {
    return Supabase.instance.client
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('chat_id', matchedUser?['chat_id'])
        .order('created_at', ascending: true)
        .map((data) =>
            data.map<Message>((json) => Message.fromJson(json)).toList());
  }

  Future<void> postMessage(String chatId, String message) async {
    await Supabase.instance.client.from('message').insert({
      'sender': user?.id,
      'message': message,
      'chat_id': matchedUser?['chat_id']
    });
  }
}
