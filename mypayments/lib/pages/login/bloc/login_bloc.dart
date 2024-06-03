import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/pages/login/bloc/login_state.dart';
import 'package:mypayments/services/user_service.dart';
import 'package:mypayments/utils/service_locator.dart';

class LoginBloc extends Cubit<LoginState> {
  final UserService service;
  final AppController appController;

  LoginBloc([UserService? userService, AppController? controller])
      : service = userService ?? getIt.get<UserService>(),
        appController = controller ?? getIt.get<AppController>(),
        super(LoginState(isLoading: false));

  Future<bool> login(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    var result = await service.login(email, password);
    return result.fold((success) {
      appController.setUser(success);
      return true;
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
      return false;
    });
  }
}
