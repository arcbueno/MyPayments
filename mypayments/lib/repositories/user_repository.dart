import 'package:mypayments/external/user_api.dart';
import 'package:mypayments/exceptions/user_not_found.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/utils/service_locator.dart';

class UserRepository {
  final UserAPI api;

  UserRepository([UserAPI? api]) : api = api ?? getIt.get<UserAPI>();

  Future<User> login(String email, String password) async {
    var result = await api.login(email, password);
    if (result == null) {
      throw UserNotFound();
    }
    return User.fromMap(result);
  }

  Future<Contact> addContact(Contact contact) async {
    await api.addContact(contact);
    return contact;
  }
}
