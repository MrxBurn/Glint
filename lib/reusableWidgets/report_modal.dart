import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/models/chat.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void openReportDialog(BuildContext context, TextEditingController controller,
    String reportedUser, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Reason for report:'),
            const Gap(12),
            CustomTextBox(controller: controller)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await reportUser(controller.text, reportedUser);

              ref.invalidate(messageNotifierProvider);
              ref.invalidate(fetchMatchedUsersProvider);
              ref.invalidate(chatRoomNotifierProvider);

              ref.read(homeRouterNotifierProvider.notifier).updateIndex(1);

              await ref
                  .read(chatRoomNotifierProvider.notifier)
                  .updateChatRoom();

              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

Future<void> reportUser(String reason, String reportedUser) async {
  await Supabase.instance.client.from('report').insert({
    'reporter': Supabase.instance.client.auth.currentUser?.id,
    'reason': reason,
    'reported_user': reportedUser
  });
}
