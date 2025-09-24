part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

final class VerifyOtpButtonclickEvent extends VerifyOtpEvent {
  final String customerId;
  final String otp;

  VerifyOtpButtonclickEvent({required this.customerId, required this.otp});


}
