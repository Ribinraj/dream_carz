part of 'payment_status_bloc.dart';

@immutable
sealed class PaymentStatusEvent {}
final class Paymentstatuseventcalling extends PaymentStatusEvent{
  final String orderId;

  Paymentstatuseventcalling({required this.orderId});
}