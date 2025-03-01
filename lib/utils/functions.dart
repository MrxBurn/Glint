import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/isChatting.dart';

String capitalise(String text) {
  return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
}
