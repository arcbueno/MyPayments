import 'package:mypayments/app_controller.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/models/transaction.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/utils/service_locator.dart';

class RechargeApi {
  final AppController controller;

  RechargeApi([AppController? controller])
      : controller = controller ?? getIt.get<AppController>();

  Future<User> topup(Contact contact, double value) async {
    await Future.delayed(const Duration(seconds: 2));
    // Basic internal logic for API
    // User is identified by the token from header
    var user = controller.state.user!;
    user = user.copyWith(balance: user.balance - value);
    var newTransaction = Transaction(date: DateTime.now(), value: value);
    contact = contact.copyWith(history: [...contact.history, newTransaction]);
    final index =
        user.contacts.indexWhere((element) => element.number == contact.number);
    user.contacts[index] = contact;

    return user;
  }
}
