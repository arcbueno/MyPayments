import 'package:get_it/get_it.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/external/recharge_api.dart';
import 'package:mypayments/external/user_api.dart';
import 'package:mypayments/repositories/recharge_repository.dart';
import 'package:mypayments/repositories/user_repository.dart';
import 'package:mypayments/services/recharge_service.dart';
import 'package:mypayments/services/user_service.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerSingleton(AppController());
    getIt.registerSingleton<UserAPI>(UserAPI());
    getIt.registerSingleton<UserRepository>(
      UserRepository(
        getIt.get(),
      ),
    );
    getIt.registerSingleton<UserService>(
      UserService(
        getIt.get(),
      ),
    );

    getIt.registerSingleton<RechargeApi>(RechargeApi(getIt.get()));
    getIt.registerSingleton<RechargeRepository>(
      RechargeRepository(
        getIt.get(),
      ),
    );
    getIt.registerSingleton<RechargeService>(
      RechargeService(
        getIt.get<RechargeRepository>(),
        getIt.get<AppController>(),
      ),
    );
  }
}
