import 'package:mypayments/utils/text_data.dart';

class InsuffientBalance implements Exception {
  final String message = TextData.insufficientBalance;
  InsuffientBalance();
  @override
  String toString() {
    return message;
  }
}
