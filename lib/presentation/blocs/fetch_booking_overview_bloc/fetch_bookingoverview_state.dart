part of 'fetch_bookingoverview_bloc.dart';

@immutable
sealed class FetchBookingoverviewState {}

final class FetchBookingoverviewInitial extends FetchBookingoverviewState {}

final class FetchBookingoverviewLoadingState
    extends FetchBookingoverviewState {}

final class FetchBookingoverviewSuccessState extends FetchBookingoverviewState {
  final BookingOverviewModel booking;

  FetchBookingoverviewSuccessState({required this.booking});
}

final class FetchBookingoverviewErrorState extends FetchBookingoverviewState {
  final String message;

  FetchBookingoverviewErrorState({required this.message});
}
