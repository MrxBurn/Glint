import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homeRouter.g.dart';

@Riverpod(keepAlive: true)
class HomeRouterNotifier extends _$HomeRouterNotifier {
  @override
  int build() {
    return 1;
  }

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}
