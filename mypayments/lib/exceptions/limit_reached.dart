import 'package:mypayments/utils/text_data.dart';

class LimitReached implements Exception {
  final String message = TextData.limitReached;
  LimitReached();
  @override
  String toString() {
    return message;
  }
}
