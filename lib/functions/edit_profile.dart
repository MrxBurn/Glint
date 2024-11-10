import 'package:flutter/material.dart';
import 'package:glint/classes/user.dart';

bool hasDataChanged(
  UserClass currentSettings,
  String genderValue,
  String interestValue,
  String lookingForValue,
  List<String> selectedHobbies,
  RangeValues ageRange,
) {
  return currentSettings.gender != genderValue ||
      currentSettings.interestIn != interestValue ||
      currentSettings.lookingFor != lookingForValue ||
      currentSettings.hobbies.length != selectedHobbies.length ||
      currentSettings.minAge != ageRange.start.toInt() ||
      currentSettings.maxAge != ageRange.end.toInt();
}
