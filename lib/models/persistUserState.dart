import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'persistUserState.g.dart';

@Riverpod(keepAlive: true)
Stream<AuthState> persistUser(Ref ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}
