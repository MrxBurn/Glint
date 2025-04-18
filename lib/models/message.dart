import 'package:glint/models/encryption.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<String> getMessage(EncryptionRepo repo, UserClass? currentUser,
      Map<String, dynamic>? matchedUser, String encryptedMessage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final derivedKey = await repo.deriveKey(
      prefs.getString('privateKey_${currentUser?.id}') ?? '',
      matchedUser?['public_key'],
    );

    final decryptedMessage = await repo.decryptMessage(
      encryptedMessage,
      derivedKey,
    );

    return decryptedMessage;
  }

  Stream<List<Message>> streamMessages() async* {
    final encryptionRepo = EncryptionRepo();

    final stream = Supabase.instance.client
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('chat_id', matchedUser?['chat_id'])
        .order('created_at', ascending: true);

    await for (final data in stream) {
      final messages = await Future.wait(
        data.map((json) async {
          final decrypted = await getMessage(
            encryptionRepo,
            user,
            matchedUser,
            json['message'],
          );

          return Message.fromJson({
            ...json,
            'message': decrypted,
          });
        }),
      );

      yield messages;
    }
  }

  Future<void> postMessage(String chatId, String message) async {
    await Supabase.instance.client.from('message').insert({
      'sender': user?.id,
      'message': message,
      'chat_id': matchedUser?['chat_id'],
    });
  }
}
