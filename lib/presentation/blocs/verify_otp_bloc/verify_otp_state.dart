part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoadingState extends VerifyOtpState {}

final class VerifyOtpSuccessState extends VerifyOtpState {}

final class VerifyOtpErrorState extends VerifyOtpState {
  final String message;

  VerifyOtpErrorState({required this.message});
}
