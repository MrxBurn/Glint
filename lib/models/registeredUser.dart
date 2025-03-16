import 'dart:typed_data';

import 'package:glint/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'registeredUser.g.dart';

@riverpod
class RegisteredUserNotifier extends _$RegisteredUserNotifier {
  @override
  AuthResponse? build() {
    return null;
  }

  void setRegisteredUser(AuthResponse user) {
    state = user;
  }

  Future<void> uploadProfilePhoto(
      Uint8List? photo, String photoName, String folderName) async {
    try {
      if (photo != null) {
        await supabase.storage.from('authDocuments').uploadBinary(
              '$folderName/${state?.user?.id}_$photoName.png',
              photo,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: false),
            );
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
    }
  }
}
