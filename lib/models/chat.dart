import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/matchUser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat.g.dart';

Future<void> update(String chatId, Map<String, dynamic> updatedData) async {
  await Supabase.instance.client
      .from('chat')
      .update(updatedData)
      .eq('id', chatId);
}

Future<void> delete(String chatId) async {
  await Supabase.instance.client
      .rpc('delete_chat_and_messages', params: {'p_chat_id': chatId});
}

@riverpod
class ChatRoomNotifier extends _$ChatRoomNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    return await fetchChatRoom();
  }

  Future<Map<String, dynamic>> fetchChatRoom() async {
    Map<String, dynamic>? matchedUser =
        ref.read(fetchMatchedUsersProvider).value;

    return await Supabase.instance.client
        .from('chat')
        .select()
        .eq('id', matchedUser?['chat_id'])
        .single();
  }

  Future<void> updateChatRoom() async {
    if (state.value == null) {
      return;
    }

    String stateValueChatId = state.value?['id'] ?? '';

    if (state.value?['user_1_active'] == false) {
      await update(stateValueChatId, {'user_2_active': false});
      await delete(stateValueChatId);
    }
    if (state.value?['user_2_active'] == false) {
      await update(stateValueChatId, {'user_1_active': false});
      await delete(stateValueChatId);
    }
    if (state.value?['user_1_active'] == true &&
        state.value?['user_2_active'] == true) {
      await update(stateValueChatId, {'user_1_active': false});
    }
    ref.invalidateSelf();
  }
}
