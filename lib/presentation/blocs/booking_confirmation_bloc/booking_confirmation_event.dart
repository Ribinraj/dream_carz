part of 'booking_confirmation_bloc.dart';

@immutable
sealed class BookingConfirmationEvent {}
final class BookingConfirmationButtonClickEvent extends BookingConfirmationEvent{
  final ConfirmBookingmodel booking;

  BookingConfirmationButtonClickEvent({required this.booking});
}