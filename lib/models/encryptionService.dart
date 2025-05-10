import 'package:glint/environments.dart';
import 'package:glint/models/encryption.dart';

class Encryptionservice {
  final encryptor = MessageEncryptor(SupabaseEnv.encryptionKey);

  String encryptMessage(String message) {
    return encryptor.encrypt(message);
  }

  String decryptMessage(String message) {
    return encryptor.decrypt(message);
  }
}
