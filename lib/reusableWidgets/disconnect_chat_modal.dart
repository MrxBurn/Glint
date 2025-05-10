import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/chat.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';

void openBox(BuildContext context, WidgetRef ref) {
  ref.invalidate(chatRoomNotifierProvider);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(0),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Text(
            'Are you sure you want to end the chat?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                ref.read(homeRouterNotifierProvider.notifier).updateIndex(1);

                ref.invalidate(messageNotifierProvider);
                ref.invalidate(fetchMatchedUsersProvider);
                ref.invalidate(chatRoomNotifierProvider);

                await ref
                    .read(chatRoomNotifierProvider.notifier)
                    .updateChatRoom();

                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    },
  );
}
