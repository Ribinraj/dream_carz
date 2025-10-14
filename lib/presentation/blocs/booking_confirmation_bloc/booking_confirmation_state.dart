part of 'booking_confirmation_bloc.dart';

@immutable
sealed class BookingConfirmationState {}

final class BookingConfirmationInitial extends BookingConfirmationState {}
final class BookingConfirmationLoadingState extends BookingConfirmationState{}
final class BookingConfirmationSuccessState extends BookingConfirmationState{
  final BookedCarmodel car;

  BookingConfirmationSuccessState({required this.car});
}
final class BookingConfirmationErrorState extends BookingConfirmationState{
  final String message;

  BookingConfirmationErrorState({required this.message});
}