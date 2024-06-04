import 'package:mypayments/models/contact.dart';

class UserAPI {
  static const verifiedUser = {
    'email': 'verified@email.com',
    'password': '12345',
  };
  static const unverifiedUser = {
    'email': 'unverified@email.com',
    'password': '12345',
  };

  Future<Map<String, dynamic>?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == verifiedUser['email'] &&
        password == verifiedUser['password']) {
      return {
        'id': '1',
        'name': 'Verified User',
        'email': verifiedUser['email'],
        'contacts': [],
        'balance': 1200.0,
        'isVerified': true,
      };
    } else if (email == unverifiedUser['email'] &&
        password == unverifiedUser['password']) {
      return {
        'id': '2',
        'name': 'Unverified User',
        'email': unverifiedUser['email'],
        'contacts': [],
        'balance': 1200.0,
        'isVerified': false,
      };
    } else {
      return null;
    }
  }

  Future<bool> addContact(Contact contact) async {
    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
