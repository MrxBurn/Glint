import 'dart:typed_data';

import 'package:glint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> uploadProfilePhoto(Uint8List? photo, String photoName,
    String folderName, String userId) async {
  try {
    if (photo != null) {
      await supabase.storage.from('authDocuments').uploadBinary(
            '$folderName/${userId}_$photoName.png',
            photo,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
    }
  } catch (e, stackTrace) {
    throw Exception(e);
  }
}

Future<void> updateProfilePhoto(Uint8List? photo, String photoName,
    String folderName, String userId) async {
  try {
    if (photo != null) {
      await supabase.storage.from('authDocuments').updateBinary(
            '$folderName/${userId}_$photoName.png',
            photo,
            fileOptions: const FileOptions(
              upsert: true,
            ),
          );
    }
  } catch (e, stackTrace) {
    throw Exception(e);
  }
}
