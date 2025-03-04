import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/matchUser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat.g.dart';

@riverpod
Future<Map<String, dynamic>> fetchChatRoom(Ref ref) async {
  Map<String, dynamic>? matchedUser =
      await ref.read(fetchMatchedUsersProvider.future);

  return await Supabase.instance.client
      .from('chat')
      .select()
      .eq('id', matchedUser?['chat_id'])
      .single();
}
