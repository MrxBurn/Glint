import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/utils/variables.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageUpload extends StatefulWidget {
  const ProfileImageUpload({super.key});

  @override
  State<ProfileImageUpload> createState() => _ProfileImageUploadState();
}

class _ProfileImageUploadState extends State<ProfileImageUpload> {
  final double gap = 16;
  XFile? image;

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: source);

    setState(() {
      image = selectedImage;
    });

    print(image?.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        children: Column(
      children: [
        const Header(),
        Padding(
          padding: paddingLRT,
          child: FormContainer(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your photo',
                      style: headerStyle,
                    ),
                    const Text(
                      "Upload your first profile picture",
                      style: TextStyle(fontSize: 12),
                    ),
                    Gap(gap),
                    ElevatedButton(
                        style: const ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.transparent),
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        //TODO: Create camera/gallery selector
                        onPressed: () => pickImage,
                        child: Center(
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: darkGreen,
                            child: const Text(
                              'Upload',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )),
                    Gap(gap),
                    const Center(
                      child: Text(
                        "This is a mandatory step to ensure the safety of the users",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Gap(gap),
                    Center(
                      child: ArrowButton(
                        isDisabled: image == null,
                        onPressed: () =>
                            Navigator.pushNamed(context, 'verificationPage'),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        TextButton(
            onPressed: () => pickImage(ImageSource.camera),
            child: const Text('Test'))
      ],
    ));
  }
}
