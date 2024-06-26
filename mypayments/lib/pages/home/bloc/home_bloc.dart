import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/models/user.dart';
import 'package:mypayments/pages/home/bloc/home_state.dart';
import 'package:mypayments/utils/service_locator.dart';

class HomeBloc extends Cubit<HomeState> {
  final AppController appController;

  HomeBloc([AppController? controller])
      : appController = controller ?? getIt.get<AppController>(),
        super(HomeState(isLoading: false)) {
    // Test purpose only
    if (appController.state.user == null) {
      appController.setUser(
        User.fromMap(
          {
            'id': '1',
            'name': 'Verified User',
            'email': 'verified@email.com',
            'password': '123456',
            'contacts': [
              {
                'name': 'John',
                'number': '+971 5 837 9529',
                'history': [],
              },
              {
                'name': 'Jane',
                'number': '+971 5 837 9528',
                'history': [],
              },
              {
                'name': 'Mary',
                'number': '+971 5 837 9527',
                'history': [],
              }
            ],
            'balance': 10200.0,
            'isVerified': false,
          },
        ),
      );
    }
    emit(state.copyWith(user: appController.state.user));
  }

  void updateContacts() {
    emit(state.copyWith(user: appController.state.user));
  }
}
