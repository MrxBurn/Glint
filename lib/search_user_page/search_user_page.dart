import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/chat/chat_page.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/search_user_page/loading_screen.dart';

class SearchUserPage extends ConsumerStatefulWidget {
  const SearchUserPage({super.key});

  @override
  ConsumerState<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends ConsumerState<SearchUserPage> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final matchedUser = ref.watch(fetchMatchedUsersProvider);

    return matchedUser.when(
        data: (match) {
          if (match == null) {
            //TODO: Maybe improve this
            _timer = Timer(const Duration(seconds: 10), () {
              ref.invalidate(fetchMatchedUsersProvider);
            });
            return const LoadingScreen();
          } else {
            _timer?.cancel();
            return const ChatPage();
          }
        },
        error: (Object error, StackTrace stackTrace) {
          return const Center(
              child: Text('Something went wrong in search_user_page.dart'));
        },
        loading: () => const LoadingScreen());
  }
}
