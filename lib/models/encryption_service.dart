import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/main.dart';
import 'package:glint/models/encryption.dart';
import 'package:glint/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webcrypto/webcrypto.dart';

class EncryptionService extends AsyncNotifier<bool> {
  EncryptionRepo encryptionRepo = EncryptionRepo();

  @override
  Future<bool> build() async {
    //TODO: Move fetch of userNotifier to top not in My Account
    final user = ref.watch(userNotifierProvider).value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final localStoragePrivateKey = prefs.getString('privateKey_${user?.id}');
    final isValid = await areKeyPairsValid(user, localStoragePrivateKey);

    if (!isValid) {
      await updateKeys();
    }

    return await areKeyPairsValid(user, localStoragePrivateKey);
  }

  Future<bool> areKeyPairsValid(
      UserClass? user, String? localStoragePrivateKey) async {
    if (localStoragePrivateKey != null && user != null) {
      try {
        final privateKey = json.decode(localStoragePrivateKey);
        final publicKey = json.decode(user.publicKey);

        final importedPrivateKey = await EcdhPrivateKey.importJsonWebKey(
          privateKey,
          EllipticCurve.p256,
        );
        final importedPublicKey = await EcdhPublicKey.importJsonWebKey(
          publicKey,
          EllipticCurve.p256,
        );

        // Try to derive bits from self
        final derived =
            await importedPrivateKey.deriveBits(256, importedPublicKey);

        // Additional basic validation
        return derived.isNotEmpty;
      } catch (e) {
        print('Key validation failed: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> updateKeys() async {
    final user = await ref.watch(userNotifierProvider.future);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final keys = await encryptionRepo.generateKeys();

    await supabase
        .from('users')
        .update({'public_key': keys.publicKey}).eq('id', user.id);
  }
}

final encryptionServiceProvider =
    AsyncNotifierProvider<EncryptionService, bool>(() => EncryptionService());
