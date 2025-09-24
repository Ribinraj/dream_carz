import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/domain/loginrepo.dart';

import 'package:meta/meta.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final Loginrepo repository;
  VerifyOtpBloc({required this.repository}) : super(VerifyOtpInitial()) {
    on<VerifyOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VerifyOtpButtonclickEvent>(verifyOtp);
  }
  FutureOr<void> verifyOtp(
      VerifyOtpButtonclickEvent event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoadingState());
    try {
     

      final response = await repository.verifyotp(customerId: event.customerId, otp:event.otp);
   

      log(response.message);
      if (!response.error && response.status == 200) {
        emit(VerifyOtpSuccessState());
      } else {

        log(response.message);
        emit(VerifyOtpErrorState(message: response.message));
      }
    } catch (e) {


      log(e.toString());
      emit(VerifyOtpErrorState(message: e.toString()));
    }
  }
}
