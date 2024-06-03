import 'package:mypayments/utils/text_data.dart';

class UnexpectedError implements Exception {
  final String message = TextData.unexpectedError;
  UnexpectedError();
  @override
  String toString() {
    return message;
  }
}
