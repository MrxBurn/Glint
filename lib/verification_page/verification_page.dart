import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/models/registeredUser.dart';
import 'package:glint/models/user.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/camera_gallery_modal.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/utils/uploadPhoto.dart';
import 'package:glint/utils/variables.dart';
import 'package:image_picker/image_picker.dart';

class VerificationPage extends ConsumerStatefulWidget {
  const VerificationPage({super.key});

  @override
  ConsumerState<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  final double gap = 16;

  XFile? image;

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: source);

    setState(() {
      image = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final registeredUser =
        ref.watch(registeredUserNotifierProvider)?.user?.id ?? '';

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
                      'Verification',
                      style: headerStyle,
                    ),
                    const Text(
                      "Take a photo of your face!",
                      style: TextStyle(fontSize: 12),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(0),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () =>
                          openCameraGalleryDialog(context, pickImage),
                      child: Center(
                        child: CircleAvatar(
                            radius: 75,
                            backgroundColor: darkGreen,
                            foregroundImage: image != null
                                ? NetworkImage(image?.path ?? '')
                                : null,
                            child: image == null
                                ? const Text(
                                    'Upload face pic',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                : const SizedBox()),
                      ),
                    ),
                    Gap(gap),
                    Center(
                      child: ArrowButton(
                        isDisabled: image == null,
                        onPressed: () async {
                          final bytes = await image?.readAsBytes();
                          await uploadProfilePhoto(bytes, 'verificationPhoto',
                              'verificationPhotos', registeredUser);

                          print(registeredUser);
                          await ref
                              .read(userNotifierProvider.notifier)
                              .updateUserNoRefetch(
                                  {'is_auth_finished': true}, registeredUser);

                          ref.invalidate(userNotifierProvider);

                          Navigator.pushNamed(context, 'homePage');
                        },
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    ));
  }
}
