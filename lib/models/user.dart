import 'package:glint/main.dart';
import 'package:glint/models/persistUserState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
  final bool isAuthFinished;
  final bool isApproved;
  final String publicKey;

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
      required this.isApproved,
      required this.publicKey});

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
        publicKey: data['public_key']);
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
        isApproved: false,
        publicKey: '');
  }
}

@riverpod
class UserNotifier extends AsyncNotifier<UserClass> {
  @override
  Future<UserClass> build() async {
    final authState = await ref.watch(persistUserProvider.future);

    return await fetchUser(authState);
  }

  Future<UserClass> fetchUser(AuthState authState) async {
    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('id', authState.session?.user.id ?? '')
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
      return "${supabase.storage.from('authDocuments').getPublicUrl(
            'profilePhotos/${userId ?? state.value?.id}_profilePhoto.png',
          )}?time=${DateTime.now()}"; //fix to stop image from caching
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
    }
    return '';
  }
}

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, UserClass>(
  () => UserNotifier(),
);
