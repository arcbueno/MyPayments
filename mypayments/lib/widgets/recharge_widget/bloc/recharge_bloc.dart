import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/services/recharge_service.dart';
import 'package:mypayments/utils/service_locator.dart';
import 'package:mypayments/widgets/recharge_widget/bloc/state.dart';

class RechargeBloc extends Cubit<RechargeState> {
  final RechargeService service;
  final Contact contact;

  RechargeBloc({required this.contact, RechargeService? service})
      : service = service ?? getIt.get<RechargeService>(),
        super(RechargeState(isLoading: false));

  Future<bool> recharge(double value) async {
    emit(state.copyWith(isLoading: true));
    var result = await service.topup(contact, value);
    return result.fold((success) => true, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.toString()));
      return false;
    });
  }
}
