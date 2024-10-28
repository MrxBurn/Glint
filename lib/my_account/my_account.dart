import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/main.dart';
import 'package:glint/reusableWidgets/error_field.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/range_slider.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/functions.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

double gap = 10;

class _MyAccountState extends State<MyAccount> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  RangeValues _ageRangeValues = const RangeValues(18, 30);

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  String _genderValue = '';
  String _interestValue = '';
  String _lookingForValue = '';

  bool _formSubmitted = false;

  List<String> _selectedHobbies = [];

  double width = 200;
  double gap = 10;

  void onTileSelected(int index, String? type) => {
        setState(() {
          if (type == 'gender') {
            if (_genderSelectedIndex == index) {
              _genderSelectedIndex = null;
              _genderValue = '';
            } else {
              _genderSelectedIndex = index;
              _genderValue = genders[index];
            }
          } else if (type == 'interestedIn') {
            if (_interestSelectedIndex == index) {
              _interestSelectedIndex = null;
              _interestValue = '';
            } else {
              _interestSelectedIndex = index;
              _interestValue = genders[index];
            }
          } else {
            if (_lookingForIndex == index) {
              _lookingForIndex = null;
              _lookingForValue = '';
            } else {
              _lookingForIndex = index;
              _lookingForValue = lookingForList[index];
            }
          }
          _formSubmitted = false;
        })
      };

  void onMultiTileSelect(String value) {
    setState(() {
      if (_selectedHobbies.contains(value)) {
        _selectedHobbies.remove(value);
      } else {
        _selectedHobbies.add(value);
      }
    });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    setState(() {
      if (pickedDate != null) {
        dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      } else {
        dobController.text = '';
      }
    });
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    UserResponse user = await supabase.auth.getUser();

    if (user.user?.id != null) {
      List<Map<String, dynamic>> response =
          await supabase.from('users').select().eq('id', user.user!.id);
      return response;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: getUser(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var data = snapshot.data[0];

                          _genderSelectedIndex =
                              genders.indexOf(data['gender']);
                          _selectedHobbies +=
                              List<String>.from(data['hobbies']);
                          _interestSelectedIndex =
                              genders.indexOf(data['interest_in']);

                          //TODO: Continue
                          _lookingForIndex =
                              lookingForList.indexOf(data['looking_for']);

                          print(_lookingForIndex);
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Account',
                                  style: headerStyle,
                                ),
                                ElevatedButton(
                                    onPressed: () => supabase.auth.signOut(),
                                    child: const Text('Logout')),
                                Gap(gap),
                                CustomTextBox(
                                  labelText: 'Date of birth',
                                  readOnly: true,
                                  width: width,
                                  controller: dobController,
                                  onTap: () => selectDate(context),
                                  validator: (text) {
                                    if (dobController.text.isEmpty) {
                                      return 'Please enter your DOB';
                                    }
                                    if (DateTime.now().year -
                                            DateFormat('dd-MM-yyyy')
                                                .parse(dobController.text)
                                                .year <
                                        18) {
                                      return 'You must be over 18 years old';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(24),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    CustomTextBox(
                                      labelText: 'Height',
                                      validator: (text) {
                                        if (heightController.text.isEmpty) {
                                          return 'Please enter your height';
                                        }
                                        return null;
                                      },
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
                                            onTap: () =>
                                                onTileSelected(idx, 'gender'),
                                            isSelected:
                                                _genderSelectedIndex == idx,
                                          );
                                        })),
                                Gap(gap),
                                _formSubmitted && _genderValue.isEmpty
                                    ? const ErrorField(
                                        error: 'Please select a gender')
                                    : const SizedBox(),
                                Gap(gap),
                                Row(
                                  children: [
                                    const Text('Hobbies:'),
                                    const Gap(8),
                                    _selectedHobbies.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedHobbies.clear();
                                              });
                                            },
                                            child: Text(
                                              'Clear all',
                                              style: TextStyle(
                                                  color: darkGreen,
                                                  fontSize: 12,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: darkGreen),
                                            ))
                                        : const SizedBox()
                                  ],
                                ),
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
                                        onTap: () =>
                                            onMultiTileSelect(hobbiesList[idx]),
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                _formSubmitted && _selectedHobbies.isEmpty
                                    ? const ErrorField(
                                        error:
                                            'Please select at least one hobby')
                                    : const SizedBox(),
                                Gap(gap),
                                Text(
                                  'Your interests',
                                  style: headerStyle,
                                ),
                                const Text(
                                  "What are you looking for?",
                                  style: TextStyle(fontSize: 12),
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
                                        onTap: () =>
                                            onTileSelected(idx, 'interestedIn'),
                                        isSelected:
                                            _interestSelectedIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                _formSubmitted && _interestValue.isEmpty
                                    ? const ErrorField(
                                        error: 'Please select your interest')
                                    : const SizedBox(),
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
                                    itemCount: lookingForList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return MultiSelectBox(
                                        hobby: lookingForList[idx],
                                        onTap: () => onTileSelected(idx, ''),
                                        isSelected: _lookingForIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                _formSubmitted && _lookingForValue.isEmpty
                                    ? const ErrorField(
                                        error:
                                            'Please select at least one option')
                                    : const SizedBox(),
                                const Gap(16),
                                const Text('Age'),
                                const Gap(8),
                                CustomRangeSlider(
                                  divisions: 70,
                                  start: 18,
                                  end: 70,
                                  rangeValues: _ageRangeValues,
                                  onChanged: (RangeValues values) => {
                                    setState(() {
                                      _ageRangeValues = values;
                                    })
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
