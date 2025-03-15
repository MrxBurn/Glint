import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registeredUser.g.dart';

@riverpod
class RegisteredUserNotifier extends _$RegisteredUserNotifier {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void setRegisteredUser(Map<String, dynamic> user) {
    state = user;
  }
}
