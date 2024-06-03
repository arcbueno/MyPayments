import 'package:mypayments/models/user.dart';

class HomeState {
  final bool isLoading;
  final User? user;
  HomeState({
    required this.isLoading,
    this.user,
  });

  HomeState copyWith({
    bool? isLoading,
    User? user,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
