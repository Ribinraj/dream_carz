import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'payment_status_event.dart';
part 'payment_status_state.dart';

class PaymentStatusBloc extends Bloc<PaymentStatusEvent, PaymentStatusState> {
  final Apprepo repository;
  PaymentStatusBloc({required this.repository}) : super(PaymentStatusInitial()) {
    on<PaymentStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Paymentstatuseventcalling>(paymentstatus);
  }

  FutureOr<void> paymentstatus(Paymentstatuseventcalling event, Emitter<PaymentStatusState> emit) async{
    emit(PaymentStatusLoadingState());
    try {
      final response=await repository.bookingstatus(orderId: event.orderId);
      if (!response.error && response.status==200) {
        emit(PaymentStatusSuccessState());
      }
      else{
        emit(PaymentStatusErrorState(message: response.message));
      }
    } catch (e) {
      emit(PaymentStatusErrorState(message: e.toString()));
    }
  }
}
