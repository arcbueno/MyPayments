import 'package:get_it/get_it.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/db/user_db.dart';
import 'package:mypayments/repositories/user_repository.dart';
import 'package:mypayments/services/user_service.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerSingleton(AppController());
    getIt.registerSingleton<UserDB>(UserDB());
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
  }
}
