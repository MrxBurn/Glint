import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/classes/user.dart';
import 'package:glint/functions/edit_profile.dart';
import 'package:glint/reusableWidgets/error_field.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/range_slider.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';

class EditPreferences extends StatefulWidget {
  const EditPreferences({super.key, required this.user});

  final UserClass user;

  @override
  State<EditPreferences> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  TextEditingController ageController = TextEditingController();
  RangeValues _ageRangeValues = const RangeValues(0, 0);

  double width = 200;
  double gap = 10;

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  String _genderValue = '';
  String _interestValue = '';
  String _lookingForValue = '';

  bool _formSubmitted = false;

  List<String> _selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    _genderSelectedIndex = genders.indexOf(widget.user.gender);
    _selectedHobbies += List<String>.from(widget.user.hobbies);
    _interestSelectedIndex = genders.indexOf(widget.user.interestIn);
    _lookingForIndex = lookingForListEnums.indexOf(widget.user.lookingFor);

    _ageRangeValues = RangeValues(
        widget.user.minAge.toDouble(), widget.user.maxAge.toDouble());

    _genderValue = widget.user.gender;
    _interestValue = widget.user.interestIn;
    _lookingForValue = widget.user.lookingFor;
  }

  void onTileSelected(int index, String? type) {
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
          _lookingForValue = lookingForListEnums[index];
        }
      }
      _formSubmitted = false;
    });
  }

  void onMultiTileSelect(String value) {
    setState(() {
      if (_selectedHobbies.contains(value)) {
        _selectedHobbies.remove(value);
      } else {
        _selectedHobbies.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      shouldNavigateBack: true,
      children: Column(
        children: [
          const Header(),
          Padding(
            padding: paddingLRT,
            child: FormContainer(
                child: Column(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Account',
                        style: headerStyle,
                      ),
                      const Gap(24),
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
                                  onTap: () {
                                    setState(() {
                                      onTileSelected(
                                        idx,
                                        'gender',
                                      );
                                    });
                                  },
                                  isSelected: _genderSelectedIndex == idx,
                                );
                              })),
                      Gap(gap),
                      _formSubmitted && _genderSelectedIndex == null
                          ? const ErrorField(error: 'Please select a gender')
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
                                        decoration: TextDecoration.underline,
                                        decorationColor: darkGreen),
                                  ))
                              : const SizedBox()
                        ],
                      ),
                      Gap(gap),
                      Gap(gap),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Gap(6),
                          scrollDirection: Axis.horizontal,
                          itemCount: hobbiesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return MultiSelectBox(
                              hobby: hobbiesList[idx],
                              isSelected:
                                  _selectedHobbies.contains(hobbiesList[idx]),
                              onTap: () => onMultiTileSelect(hobbiesList[idx]),
                            );
                          },
                        ),
                      ),
                      Gap(gap),
                      _formSubmitted && _selectedHobbies.isEmpty
                          ? const ErrorField(
                              error: 'Please select at least one hobby')
                          : const SizedBox(),
                      Gap(gap),
                      const Text('Interested in:'),
                      Gap(gap),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Gap(6),
                          scrollDirection: Axis.horizontal,
                          itemCount: genders.length,
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return SingleSelectBox(
                              color: colourList[idx],
                              imageString: images[idx],
                              gender: genders[idx],
                              onTap: () {
                                setState(() {
                                  onTileSelected(
                                    idx,
                                    'interestedIn',
                                  );
                                });
                              },
                              isSelected: _interestSelectedIndex == idx,
                            );
                          },
                        ),
                      ),
                      Gap(gap),
                      _formSubmitted && _interestSelectedIndex == null
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
                          separatorBuilder: (context, index) => const Gap(6),
                          scrollDirection: Axis.horizontal,
                          itemCount: lookingForText.length,
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return MultiSelectBox(
                              hobby: lookingForText[idx],
                              onTap: () => onTileSelected(idx, ''),
                              isSelected: _lookingForIndex == idx,
                            );
                          },
                        ),
                      ),
                      Gap(gap),
                      _formSubmitted && _lookingForIndex == null
                          ? const ErrorField(
                              error: 'Please select at least one option')
                          : const SizedBox(),
                      Gap(gap),
                      const Text('Age'),
                      Gap(gap),
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
                      const Gap(24),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _formSubmitted = true;

                                print(hasDataChanged(
                                    widget.user,
                                    _genderValue,
                                    _interestValue,
                                    _lookingForValue,
                                    _selectedHobbies));
                              });

                              if (_genderSelectedIndex != null &&
                                  _interestSelectedIndex != null &&
                                  _selectedHobbies.isNotEmpty &&
                                  _lookingForIndex != null) {
                                if (hasDataChanged(
                                        widget.user,
                                        _genderValue,
                                        _interestValue,
                                        _lookingForValue,
                                        _selectedHobbies) ==
                                    true) {
//TODO: Append changes
                                } else {
                                  //DO NOUT
                                }
                              }
                            },
                            child: const Text('Save')),
                      ),
                      Gap(gap),
                    ],
                  ),
                ),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
