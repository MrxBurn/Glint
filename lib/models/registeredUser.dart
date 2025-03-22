import 'dart:typed_data';

import 'package:glint/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'registeredUser.g.dart';

@riverpod
class RegisteredUserNotifier extends _$RegisteredUserNotifier {
  @override
  AuthResponse? build() {
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        state = AuthResponse(session: data.session!, user: data.session!.user);
      }
    });
    return null;
  }

  void setRegisteredUser(AuthResponse user) {
    state = user;
  }
}
