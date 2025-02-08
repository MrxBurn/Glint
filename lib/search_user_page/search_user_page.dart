import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/user.dart';
import 'package:glint/search_user_page/loading_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchUserPage extends ConsumerStatefulWidget {
  const SearchUserPage({super.key});

  @override
  ConsumerState<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends ConsumerState<SearchUserPage> {
  Future<Map<String, dynamic>> fetchMatchedUsers(UserClass user) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.rpc('get_matching_users', params: {
        'p_user_id': user.id,
        'p_gender': user.gender,
        'p_interest_in': user.interestIn,
        'p_min_age': user.minAge,
        'p_max_age': user.maxAge,
        'p_looking_for': user.lookingFor,
      });

      return List<Map<String, dynamic>>.from(response)[0];
    } catch (error) {
      throw Exception('Failed to fetch matched users');
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(userNotifierProvider.notifier).updateUser({'is_active': true});
  }

  //TODO: Continue chat implementation

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider).value as UserClass;
    return FutureBuilder<Object>(
        future: fetchMatchedUsers(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
