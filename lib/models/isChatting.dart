import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isChatting.g.dart';

@riverpod
class IsChattingNotifier extends _$IsChattingNotifier {
  @override
  bool build() {
    return false;
  }

  void setIsChatting(bool newIsChattingValue) {
    state = newIsChattingValue;
  }
}
