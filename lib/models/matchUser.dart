import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/chatExists.dart';
import 'package:glint/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'matchUser.g.dart';

@riverpod
Future<Map<String, dynamic>?> fetchMatchedUsers(Ref ref) async {
  final supabase = Supabase.instance.client;

  await ref
      .watch(userNotifierProvider.notifier)
      .updateUserNoRefetch({'is_active': true});

  final user = ref.read(userNotifierProvider).value as UserClass;

  try {
    //check if chat exists
    List<Map<String, dynamic>> existingChat = await supabase
        .rpc('check_if_chat_exists', params: {'p_user1_id': user.id});

    //if doesn't exist
    if (existingChat[0]['existing_chat_id'] == null) {
      //do matching logic
      List<Map<String, dynamic>> matchedUser =
          await supabase.rpc('get_matching_users', params: {
        'p_user_id': user.id,
        'p_gender': user.gender,
        'p_interest_in': user.interestIn,
        'p_min_age': user.minAge,
        'p_max_age': user.maxAge,
        'p_looking_for': user.lookingFor,
      });

      //if match found, create chat
      if (matchedUser.isNotEmpty) {
        final chat = await supabase.rpc('start_chat', params: {
          'p_user1_id': user.id,
          'p_user2_id': matchedUser[0]['id']
        });

        return {...matchedUser[0], 'chat_id': chat};
      }
    } else {
      // get current existing chat and return it
      final userFromChat = await getUserFromChat(existingChat[0], user);

      return {
        ...userFromChat,
        'chat_id': existingChat[0]['existing_chat_id'],
      };
    }
  } catch (error, stackTrace) {
    // throw Exception('Failed to fetch matched users');

    print(error);
    print(stackTrace);
  }
  return null;
}
