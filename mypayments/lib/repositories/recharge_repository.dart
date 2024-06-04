import 'package:mypayments/external/recharge_api.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/utils/service_locator.dart';

class RechargeRepository {
  final RechargeApi api;

  RechargeRepository([RechargeApi? api])
      : api = api ?? getIt.get<RechargeApi>();

  Future<User> topup(Contact contact, double value) async {
    return api.topup(contact, value);
  }
}
