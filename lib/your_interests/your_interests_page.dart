import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/range_slider.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';

class YourInterestsPage extends StatefulWidget {
  const YourInterestsPage({super.key});

  @override
  State<YourInterestsPage> createState() => _YourInterestsPageState();
}

class _YourInterestsPageState extends State<YourInterestsPage> {
  TextEditingController ageController = TextEditingController();
  RangeValues _ageRangeValues = const RangeValues(18, 70);
  final RangeValues _searchRadiusRangeValues = const RangeValues(1, 100);

  int? _genderSelectedIndex;

  void onTileSelected(int index) => {
        setState(() {
          if (_genderSelectedIndex == index) {
            _genderSelectedIndex = null;
          } else {
            _genderSelectedIndex = index;
          }
        })
      };

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
                      'Your interests',
                      style: headerStyle,
                    ),
                    const Text(
                      "What are you looking for?",
                      style: TextStyle(fontSize: 12),
                    ),
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
                    const Text('Gender'),
                    const Gap(8),
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
                            onTap: () => onTileSelected(idx),
                            isSelected: _genderSelectedIndex == idx,
                          );
                        },
                      ),
                    ),
                    const Gap(16),
                    const Text(
                      'Search radius - to come later',
                      style: TextStyle(color: Colors.grey),
                    ),
                    CustomRangeSlider(
                        divisions: 100,
                        start: 1,
                        end: 100,
                        rangeValues: _searchRadiusRangeValues,
                        onChanged: null

                        //  (RangeValues values) => {
                        //   setState(() {
                        //     _searchRadiusRangeValues = values;
                        //   })
                        // },
                        ),
                    const Gap(16),
                    Center(
                      child: ArrowButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'profileImageUpload'),
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
