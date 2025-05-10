import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class MessageEncryptor {
  final Key key;
  final Encrypter _encrypter;

  MessageEncryptor(String keyString)
      : key = Key.fromUtf8(keyString),
        _encrypter = Encrypter(AES(Key.fromUtf8(keyString)));

  String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16); // Use a random IV
    final encrypted = _encrypter.encrypt(plainText, iv: iv);

    // Combine IV + encrypted data and encode
    final combined = iv.bytes + encrypted.bytes;
    return base64Encode(combined);
  }

  String decrypt(String combinedBase64) {
    final combinedBytes = base64Decode(combinedBase64);

    final iv = IV(Uint8List.fromList(combinedBytes.sublist(0, 16)));
    final cipherText = Encrypted(Uint8List.fromList(combinedBytes.sublist(16)));

    return _encrypter.decrypt(cipherText, iv: iv);
  }
}
