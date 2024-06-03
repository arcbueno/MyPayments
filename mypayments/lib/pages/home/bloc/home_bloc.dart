import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/pages/home/bloc/home_state.dart';
import 'package:mypayments/utils/service_locator.dart';

class HomeBloc extends Cubit<HomeState> {
  final AppController appController;

  HomeBloc([AppController? controller])
      : appController = controller ?? getIt.get<AppController>(),
        super(HomeState(isLoading: false)) {
    emit(state.copyWith(user: appController.state.user));
  }

  // Future<void> getPayments() async {
  //   emit(state.copyWith(isLoading: true));
  //   var result = await service.getPayments();
  //   result.fold((success) {
  //     emit(state.copyWith(isLoading: false, payments: success));
  //   }, (failure) {
  //     emit(state.copyWith(isLoading: false, error: failure.toString()));
  //   });
  // }
}
