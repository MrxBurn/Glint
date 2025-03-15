import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void openCameraGalleryDialog(
    BuildContext context, Function(ImageSource source) pickImage) {
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
            TextButton.icon(
              icon: const Icon(Icons.camera_alt_rounded),
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label: const Text('Camera'),
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                alignment: Alignment.centerLeft,
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: const Text('Gallery'),
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
