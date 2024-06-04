import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/app_controller.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/services/user_service.dart';
import 'package:mypayments/utils/service_locator.dart';
import 'package:mypayments/widgets/add_contact/bloc/state.dart';

class AddContactBloc extends Cubit<AddContactState> {
  final UserService service;
  final AppController appController;

  AddContactBloc([UserService? service, AppController? appController])
      : service = service ?? getIt.get<UserService>(),
        appController = appController ?? getIt.get<AppController>(),
        super(AddContactState(isLoading: false));

  Future<bool> addContact(Contact contact) async {
    emit(state.copyWith(isLoading: true));
    var result = await service.addContact(contact);
    return result.fold((success) {
      appController.addContact(success);
      return true;
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
      return false;
    });
  }
}
