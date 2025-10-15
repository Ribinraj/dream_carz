import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/booked_carmodel.dart';
import 'package:dream_carz/data/confirm_bookingmodel.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'booking_confirmation_event.dart';
part 'booking_confirmation_state.dart';

class BookingConfirmationBloc extends Bloc<BookingConfirmationEvent, BookingConfirmationState> {
  final Apprepo repository;
  BookingConfirmationBloc({required this.repository}) : super(BookingConfirmationInitial()) {
    on<BookingConfirmationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<BookingConfirmationButtonClickEvent>(confirmbooking);
  }

  FutureOr<void> confirmbooking(BookingConfirmationButtonClickEvent event, Emitter<BookingConfirmationState> emit)async {
    emit(BookingConfirmationLoadingState());
    final response=await repository.bookingconfirmation(bookingdetails: event.booking);
    try {
          if (!response.error && response.status==200) {
      emit(BookingConfirmationSuccessState(car: response.data!));
    }else{
      emit(BookingConfirmationErrorState(message: response.message));
    }
    } catch (e) {
      emit(BookingConfirmationErrorState(message: e.toString()));
    }

  }
}
