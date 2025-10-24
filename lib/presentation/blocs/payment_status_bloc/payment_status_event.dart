part of 'payment_status_bloc.dart';

@immutable
sealed class PaymentStatusEvent {}
final class Paymentstatuseventcalling extends PaymentStatusEvent{
  final String bookingId;

  Paymentstatuseventcalling({required this.bookingId});
}