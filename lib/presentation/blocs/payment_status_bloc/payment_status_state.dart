part of 'payment_status_bloc.dart';

@immutable
sealed class PaymentStatusState {}

final class PaymentStatusInitial extends PaymentStatusState {}
final class PaymentStatusLoadingState extends PaymentStatusState{}
final class PaymentStatusSuccessState extends PaymentStatusState{

}
final class PaymentStatusErrorState extends PaymentStatusState{
  final String message;

  PaymentStatusErrorState({required this.message});
}