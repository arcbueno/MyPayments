import 'package:mypayments/models/user.dart';

class AppController {
  AppState _appState = AppState(user: null);
  AppState get state => _appState;
  AppController();

  void setUser(User user) {
    _appState = _appState.copyWith(user: user);
  }
}

class AppState {
  final User? user;
  bool get isLoggedIn => user != null;

  AppState({required this.user});

  AppState copyWith({
    User? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
