import 'package:glint/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.g.dart';

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
  final bool isAuthFinished;
  final bool isApproved;

  UserClass(
      {required this.id,
      required this.minAge,
      required this.maxAge,
      required this.gender,
      required this.hobbies,
      required this.interestIn,
      required this.lookingFor,
      required this.dob,
      required this.height,
      required this.isAuthFinished,
      required this.isApproved});

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
      isAuthFinished: data['is_auth_finished'],
      isApproved: data['is_approved'],
    );
  }
  factory UserClass.defaultUser() {
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
        isAuthFinished: false,
        isApproved: false);
  }
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<UserClass> build() async {
    return await fetchUser();
  }

  Future<UserClass> fetchUser() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('id', user?.id ?? '')
        .single();

    return UserClass.fromMap(response);
  }

  Future<void> updateUserAndRefetch(
    Map<String, dynamic> updatedData,
  ) async {
    await supabase
        .from('users')
        .update(updatedData)
        .eq('id', state.value?.id ?? '');

    ref.invalidateSelf();
  }

  Future<void> updateUserNoRefetch(Map<String, dynamic> updatedData,
      [String userId = '']) async {
    await supabase
        .from('users')
        .update(updatedData)
        .eq('id', state.value?.id ?? userId);
  }

  String getProfilePhoto({String? userId}) {
    try {
      return supabase.storage.from('authDocuments').getPublicUrl(
            'profilePhotos/${userId ?? state.value?.id}_profilePhoto.png',
          );
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
    }
    return '';
  }
}
