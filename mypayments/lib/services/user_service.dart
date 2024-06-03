import 'package:mypayments/exceptions/unexpected_error.dart';
import 'package:mypayments/exceptions/user_not_found.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/repositories/user_repository.dart';
import 'package:mypayments/utils/service_locator.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:result_dart/result_dart.dart';

class UserService {
  final UserRepository repository;
  UserService([UserRepository? userRepository])
      : repository = userRepository ?? getIt.get<UserRepository>();

  Future<Result<User, Exception>> login(String email, String password) async {
    try {
      var result = await repository.login(email, password);
      return Success(result);
    } catch (e) {
      if (e is Exception) {
        if (e is UserNotFound) {
          return Failure(Exception(TextData.notFoundErrorLogin));
        }
        return Failure(e);
      }
      return Failure(UnexpectedError());
    }
  }
}
