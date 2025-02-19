import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'matchUser.g.dart';

@riverpod
Future<Map<String, dynamic>?> fetchMatchedUsers(Ref ref) async {
  final supabase = Supabase.instance.client;

  ref.read(userNotifierProvider.notifier
      .select((v) => v.updateUserNoRefetch({'is_active': true})));

  final user = ref.read(userNotifierProvider).value as UserClass;

  try {
    List<Map<String, dynamic>> matchedUser =
        await supabase.rpc('get_matching_users', params: {
      'p_user_id': user.id,
      'p_gender': user.gender,
      'p_interest_in': user.interestIn,
      'p_min_age': user.minAge,
      'p_max_age': user.maxAge,
      'p_looking_for': user.lookingFor,
    });

    if (matchedUser.isNotEmpty) {
      final chat = await supabase.rpc('start_chat',
          params: {'p_user1_id': user.id, 'p_user2_id': matchedUser[0]['id']});

      return {...matchedUser[0], 'chat_id': chat};
    }
  } catch (error) {
    throw Exception('Failed to fetch matched users');
  }
  return null;
}
