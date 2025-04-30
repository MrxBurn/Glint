import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/editPreferences/edit_preferences.dart';
import 'package:glint/main.dart';
import 'package:glint/models/chat.dart';
import 'package:glint/models/encryption.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';
import 'package:glint/models/persistUserState.dart';
import 'package:glint/models/registeredUser.dart';
import 'package:glint/reusableWidgets/camera_gallery_modal.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/uploadPhoto.dart';
import 'package:glint/utils/variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:glint/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({
    super.key,
  });

  @override
  ConsumerState<MyAccount> createState() => _MyAccountState();
}

double gap = 10;

class _MyAccountState extends ConsumerState<MyAccount> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  List<String> _selectedHobbies = [];

  double width = 200;
  double gap = 10;

  UserClass? user;

  String? image;

  XFile? pickedImage;

  EncryptionRepo encryptionRepo = EncryptionRepo();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(userNotifierProvider.notifier).getProfilePhoto();
  }

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: source);

    setState(() {
      pickedImage = selectedImage;
    });

    final bytes = await pickedImage?.readAsBytes();
//TODO: Fix updateProfilePhoto - some caching issues
    if (bytes != null) {
      print('maimuta');
      await updateProfilePhoto(bytes, 'profilePhoto', 'profilePhotos',
          supabase.auth.currentUser?.id ?? '');

      ref.invalidate(userNotifierProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider);

    return SafeArea(
        child: Column(children: [
      Expanded(
        child: Padding(
          padding: paddingLRT,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                top: 60,
                child: FormContainer(
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0, top: 128),
                      child: userAsync.when(
                        data: (user) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            //reset is_active to false as not looking for match
                            ref
                                .read(userNotifierProvider.notifier)
                                .updateUserNoRefetch(
                                    {'is_active': false, 'is_chatting': false});
                          });

                          _genderSelectedIndex = genders.indexOf(user.gender);
                          _selectedHobbies = List<String>.from(user.hobbies);
                          _interestSelectedIndex =
                              genders.indexOf(user.interestIn);
                          _lookingForIndex =
                              lookingForListEnums.indexOf(user.lookingFor);

                          dobController.text = DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(user.dob))
                              .toString();
                          heightController.text = user.height.toString();

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      final res =
                                          await encryptionRepo.generateKeys();

                                      await supabase.from('users').update({
                                        'public_key': res.publicKey
                                      }).eq('id',
                                          supabase.auth.currentUser?.id ?? '');
                                    },
                                    child: const Text('Update public key')),
                                ElevatedButton(
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      print(prefs
                                          .getString('privateKey_${user.id}'));
                                    },
                                    child: const Text('Get local storage')),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditPreferences(),
                                          ),
                                        );
                                      },
                                      isLoading: false,
                                      child: const Text('Edit preferences'),
                                    )),
                                Text(
                                  'My Account',
                                  style: headerStyle,
                                ),
                                const Gap(24),
                                CustomTextBox(
                                  labelText: 'Date of birth',
                                  readOnly: true,
                                  width: width,
                                  controller: dobController,
                                  onTap: null,
                                ),
                                const Gap(24),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    CustomTextBox(
                                      readOnly: true,
                                      labelText: 'Height',
                                      width: width,
                                      controller: heightController,
                                    ),
                                    const Text('cm'),
                                  ],
                                ),
                                Gap(gap),
                                const Text('Gender:'),
                                Gap(gap),
                                SizedBox(
                                    width: double.infinity,
                                    height: 32,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Gap(6),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: genders.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, idx) {
                                          return SingleSelectBox(
                                            color: colourList[idx],
                                            imageString: images[idx],
                                            gender: genders[idx],
                                            onTap: null,
                                            isSelected:
                                                _genderSelectedIndex == idx,
                                          );
                                        })),
                                Gap(gap),
                                const Text('Hobbies:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hobbiesList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return MultiSelectBox(
                                          hobby: hobbiesList[idx],
                                          isSelected: _selectedHobbies
                                              .contains(hobbiesList[idx]),
                                          onTap: null);
                                    },
                                  ),
                                ),
                                Gap(gap),
                                const Text('Interested in:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: genders.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return SingleSelectBox(
                                        color: colourList[idx],
                                        imageString: images[idx],
                                        gender: genders[idx],
                                        onTap: null,
                                        isSelected:
                                            _interestSelectedIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                const Text('Looking for:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: lookingForText.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return MultiSelectBox(
                                        hobby: lookingForText[idx],
                                        onTap: null,
                                        isSelected: _lookingForIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                Row(
                                  children: [
                                    const Text('Age search: '),
                                    Text(
                                      "${user.minAge} - ${user.maxAge}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Gap(gap),
                                Center(
                                    child: CustomElevatedButton(
                                  onPressed: () async {
                                    ref.invalidate(userNotifierProvider);
                                    ref.invalidate(chatRoomNotifierProvider);
                                    ref.invalidate(homeRouterNotifierProvider);
                                    ref.invalidate(fetchMatchedUsersProvider);
                                    ref.invalidate(messageNotifierProvider);
                                    ref.invalidate(persistUserProvider);
                                    ref.invalidate(
                                        registeredUserNotifierProvider);

                                    await supabase.auth.signOut();
                                  },
                                  isLoading: false,
                                  child: const Text('Logout'),
                                )),
                              ],
                            ),
                          );
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return const Text('Something went wrong');
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: darkGreen,
                    backgroundImage: NetworkImage(ref
                        .read(userNotifierProvider.notifier)
                        .getProfilePhoto(
                            userId: supabase.auth.currentUser?.id)),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          style: ButtonStyle(
                              iconColor: WidgetStatePropertyAll(lightPink),
                              backgroundColor:
                                  WidgetStatePropertyAll(darkGreen)),
                          onPressed: () =>
                              openCameraGalleryDialog(context, pickImage),
                          icon: const Icon(Icons.edit)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }
}
