part of 'fetch_bookingoverview_bloc.dart';

@immutable
sealed class FetchBookingoverviewEvent {}

final class FetchBookingoverviewInitialState extends FetchBookingoverviewEvent {
  final BookingRequestmodel bookingdetails;

  FetchBookingoverviewInitialState({required this.bookingdetails});
}
