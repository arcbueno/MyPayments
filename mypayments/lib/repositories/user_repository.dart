import 'package:mypayments/db/user_db.dart';
import 'package:mypayments/exceptions/user_not_found.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/utils/service_locator.dart';

class UserRepository {
  final UserDB db;

  UserRepository([UserDB? db]) : db = db ?? getIt.get<UserDB>();

  Future<User> login(String email, String password) async {
    var result = await db.login(email, password);
    if (result == null) {
      throw UserNotFound();
    }
    return User.fromMap(result);
  }
}
