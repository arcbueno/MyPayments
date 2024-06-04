import 'package:mypayments/app_controller.dart';
import 'package:mypayments/exceptions/insuffient_balance.dart';
import 'package:mypayments/exceptions/limit_reached.dart';
import 'package:mypayments/exceptions/unexpected_error.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/repositories/recharge_repository.dart';
import 'package:mypayments/utils/constants.dart';
import 'package:mypayments/utils/service_locator.dart';
import 'package:result_dart/result_dart.dart';

class RechargeService {
  final RechargeRepository rechargeRepository;
  final AppController controller;

  RechargeService(
      RechargeRepository? rechargeRepository, AppController? appController)
      : rechargeRepository =
            rechargeRepository ?? getIt.get<RechargeRepository>(),
        controller = appController ?? getIt.get<AppController>();

  Future<Result<User, Exception>> topup(Contact contact, double value) async {
    try {
      Result<(Contact, double), Exception> validationResult =
          _validateTransaction(contact, value);
      if (validationResult is Failure) {
        return Failure(validationResult.exceptionOrNull()!);
      }

      // The user's balance should be debited first before the top-up
      // transaction is attempted.
      controller.setUser(
        controller.state.user!.copyWith(
          balance: controller.state.user!.balance - value,
        ),
      );

      var result = await rechargeRepository.topup(contact, value);
      return Success(result);
    } catch (e) {
      if (e is Exception) {
        return Failure(e);
      }
      return Failure(UnexpectedError());
    }
  }

  Result<(Contact, double), Exception> _validateTransaction(
      Contact contact, double value) {
    final user = controller.state.user!;
    if (user.balance < value) {
      return Failure(InsuffientBalance());
    }

    // User has a limit of 3000 spent for this month
    final totalSpent = user.contacts.isNotEmpty &&
            user.contacts.any((element) => element.history.isNotEmpty)
        ? user.contacts
            .map((e) => e.history
                // Spent this month
                .where((element) =>
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year)
                // Get values
                .map((e) => e.value)
                .reduce((value, element) => value + element))
            .reduce((value, element) => value + element)
        : 0.0;
    if (totalSpent >= Constants.limitSpentPerMonth) {
      return Failure(LimitReached());
    }

    final totalSpentForContact = contact.history.isNotEmpty
        ? contact.history
            // Spent this month
            .where((element) =>
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            // Get values
            .map((e) => e.value)
            .reduce((value, element) => value + element)
        : 0.0;

    // Creating if/else if statements for reading purpose only.
    // It can be easily in just one if statement
    if (user.isVerified &&
        totalSpentForContact >=
            Constants.limitSpentPerContactPerMonthVerifiedUser) {
      // if user is unverfied, validate the limit of 1000 for this
      // contact for this month
      return Failure(LimitReached());
    } else if (!user.isVerified &&
        totalSpentForContact >=
            Constants.limitSpentPerContactPerMonthUnverfiedUser) {
      // is user is verified, validate the limite of 500 for this
      // contact for this month
      return Failure(LimitReached());
    }

    return Success((contact, value));
  }
}
