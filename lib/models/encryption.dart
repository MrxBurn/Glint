import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:glint/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webcrypto/webcrypto.dart';

class JsonWebKeyPair {
  const JsonWebKeyPair({
    required this.privateKey,
    required this.publicKey,
  });
  final String privateKey;
  final String publicKey;
}

class EncryptionRepo {
  Future<JsonWebKeyPair> generateKeys() async {
    final keyPair = await EcdhPrivateKey.generateKey(EllipticCurve.p256);
    final publicKeyJwk = await keyPair.publicKey.exportJsonWebKey();
    final privateKeyJwk = await keyPair.privateKey.exportJsonWebKey();

    print("PUBLIC: $publicKeyJwk");
    print("PRIVATE: $privateKeyJwk");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('privateKey_${supabase.auth.currentUser?.id}',
        json.encode(privateKeyJwk));

    return JsonWebKeyPair(
      privateKey: json.encode(privateKeyJwk),
      publicKey: json.encode(publicKeyJwk),
    );
  }

  Future<List<int>> deriveKey(String senderJwk, String receiverJwk) async {
    // Sender's key - Current user as you are the one sending the message
    final senderPrivateKey = json.decode(senderJwk);
    final senderEcdhKey = await EcdhPrivateKey.importJsonWebKey(
      senderPrivateKey,
      EllipticCurve.p256,
    );
    // Receiver's key - Matched user as he is getting the message
    final receiverPublicKey = json.decode(receiverJwk);
    final receiverEcdhKey = await EcdhPublicKey.importJsonWebKey(
      receiverPublicKey,
      EllipticCurve.p256,
    );
    // Generating CryptoKey
    final derivedBits = await senderEcdhKey.deriveBits(256, receiverEcdhKey);
    return derivedBits;
  }

  Uint8List generateIV() {
    return Uint8List.fromList(
        'GlintIV'.codeUnits); //STORE with message itself and randomise it
  }

  Future<String> encryptMessage(String message, List<int> deriveKey) async {
    // Importing cryptoKey
    final aesGcmSecretKey = await AesGcmSecretKey.importRawKey(deriveKey);
    // Converting message into bytes
    final messageBytes = Uint8List.fromList(message.codeUnits);
    // Encrypting the message
    final encryptedMessageBytes =
        await aesGcmSecretKey.encryptBytes(messageBytes, generateIV());
    // Converting encrypted message into String
    final encryptedMessage = String.fromCharCodes(encryptedMessageBytes);
    return encryptedMessage;
  }

  Future<String> decryptMessage(
      String encryptedMessage, List<int> deriveKey) async {
    try {
      // Importing cryptoKey
      final aesGcmSecretKey = await AesGcmSecretKey.importRawKey(deriveKey);
      // Converting message into bytes
      final messageBytes = Uint8List.fromList(encryptedMessage.codeUnits);
      // Decrypting the message
      final decryptedMessageBytes =
          await aesGcmSecretKey.decryptBytes(messageBytes, generateIV());
      // Converting decrypted message into String
      final decryptedMessage = String.fromCharCodes(decryptedMessageBytes);
      return decryptedMessage;
    } catch (err, stackTrace) {
      print("Error: $err");
      print("STACK: $stackTrace");
    }

    return '';
  }

  //TODO: When sending message encrypt with derive key & decrypt when reading messages
  //Think how to fix if use removes his keys from local storage, how can I fix them
}
