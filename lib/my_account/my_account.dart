import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/editPreferences/edit_preferences.dart';
import 'package:glint/main.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';
import 'package:intl/intl.dart';
import 'package:glint/models/user.dart';

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

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider);

    return SafeArea(
        child: Column(children: [
      Expanded(
        child: Padding(
          padding: paddingLRT,
          child: FormContainer(
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: userAsync.when(
                  data: (user) {
                    //reset is_active to false as not looking for match
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateUser({'is_active': false});

                    _genderSelectedIndex = genders.indexOf(user?.gender ?? '');
                    _selectedHobbies = List<String>.from(user?.hobbies ?? []);
                    _interestSelectedIndex =
                        genders.indexOf(user?.interestIn ?? '');
                    _lookingForIndex =
                        lookingForListEnums.indexOf(user?.lookingFor ?? '');

                    dobController.text = DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(user?.dob ?? ''))
                        .toString();
                    heightController.text = user?.height.toString() ?? '';

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                      isSelected: _genderSelectedIndex == idx,
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
                                  isSelected: _interestSelectedIndex == idx,
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
                                "${user?.minAge} - ${user?.maxAge}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Gap(gap),
                          Center(
                              child: CustomElevatedButton(
                            onPressed: () => supabase.auth.signOut(),
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
      )
    ]));
  }
}
