import 'package:mypayments/utils/text_data.dart';

class UserNotFound implements Exception {
  final String message = TextData.userNotFound;
  UserNotFound();
  @override
  String toString() {
    return message;
  }
}
