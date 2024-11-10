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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:glint/classes/user.dart';

double width = 200;

double gap = 10;

class MyAccount extends ConsumerWidget {
  const MyAccount({super.key});

  Future<List<UserClass>> getUser() async {
    UserResponse user = await supabase.auth.getUser();

    if (user.user?.id != null) {
      List<Map<String, dynamic>> response =
          await supabase.from('users').select().eq('id', user.user!.id);

      return response.map((data) => UserClass.fromMap(data)).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController dobController = TextEditingController();

    TextEditingController heightController = TextEditingController();

    int? genderSelectedIndex;

    int? interestSelectedIndex;

    int? lookingForIndex;

    List<String> selectedHobbies = [];

    final data = ref.watch(userClassProvider);

    if (data.id != '0') {
      genderSelectedIndex = genders.indexOf(data.gender);
      selectedHobbies += List<String>.from(data.hobbies);
      interestSelectedIndex = genders.indexOf(data.interestIn);
      lookingForIndex = lookingForListEnums.indexOf(data.lookingFor);
      dobController.text =
          DateFormat('dd-MM-yyyy').format(DateTime.parse(data.dob)).toString();
      heightController.text = data.height.toString();
    }

    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: paddingLRT,
              child: FormContainer(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: data.id == '0'
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
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
                                          isSelected:
                                              genderSelectedIndex == idx,
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
                                        isSelected: selectedHobbies
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
                                      isSelected: interestSelectedIndex == idx,
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
                                      isSelected: lookingForIndex == idx,
                                    );
                                  },
                                ),
                              ),
                              Gap(gap),
                              Row(
                                children: [
                                  const Text('Age search: '),
                                  Text(
                                    "${data.minAge} - ${data.maxAge}",
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
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
