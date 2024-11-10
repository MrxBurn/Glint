import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserClass {
  final String id;
  final String gender;
  final List<String> hobbies;
  final String interestIn;
  final String lookingFor;
  final String dob;
  final int height;
  final int minAge;
  final int maxAge;

  UserClass({
    required this.id,
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.hobbies,
    required this.interestIn,
    required this.lookingFor,
    required this.dob,
    required this.height,
  });

  factory UserClass.fromMap(Map<String, dynamic> data) {
    return UserClass(
      id: data['id'],
      gender: data['gender'] as String,
      hobbies: List<String>.from(data['hobbies']),
      interestIn: data['interest_in'] as String,
      lookingFor: data['looking_for'] as String,
      dob: data['dob'] as String,
      height: data['height'],
      minAge: data['min_age'],
      maxAge: data['max_age'],
    );
  }
  factory UserClass.defaultUser(Map<String, dynamic> data) {
    return UserClass(
      id: '0',
      gender: 'Male',
      hobbies: [],
      interestIn: '',
      lookingFor: '',
      dob: '',
      height: 0,
      minAge: 0,
      maxAge: 0,
    );
  }
}

class UserClassNotifier extends StateNotifier<UserClass> {
  UserClassNotifier() : super(UserClass.defaultUser()) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    UserResponse user = await supabase.auth.getUser();

    if (user.user?.id != null) {
      List<Map<String, dynamic>> response =
          await supabase.from('users').select().eq('id', user.user!.id);

      state = response.map((data) => UserClass.fromMap(data)).toList()[0];
    }
  }
}

var userClassProvider =
    StateNotifierProvider<UserClassNotifier, UserClass>((ref) {
  return UserClassNotifier();
});
