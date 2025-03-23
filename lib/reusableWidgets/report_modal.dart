import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:image_picker/image_picker.dart';

void openReportDialog(BuildContext context, TextEditingController controller) {
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
            //TOOD: Implement submit report && test with matching a reported user
            onPressed: () => {},
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

//TODO: Implement this
Future<void> reportUser() async {}
