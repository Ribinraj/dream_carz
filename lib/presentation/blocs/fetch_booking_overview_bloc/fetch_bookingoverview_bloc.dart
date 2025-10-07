import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/booking_overview_model.dart';
import 'package:dream_carz/data/booking_requestmodel.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_bookingoverview_event.dart';
part 'fetch_bookingoverview_state.dart';

class FetchBookingoverviewBloc
    extends Bloc<FetchBookingoverviewEvent, FetchBookingoverviewState> {
  final Apprepo repository;
  FetchBookingoverviewBloc({required this.repository})
    : super(FetchBookingoverviewInitial()) {
    on<FetchBookingoverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchBookingoverviewInitialState>(fetchbookingoverview);
  }

  FutureOr<void> fetchbookingoverview(
    FetchBookingoverviewInitialState event,
    Emitter<FetchBookingoverviewState> emit,
  ) async {
    emit(FetchBookingoverviewLoadingState());
    try {
      final response = await repository.bookingoverview(
        details: event.bookingdetails,
      );
      if (!response.error && response.status == 200) {
        emit(FetchBookingoverviewSuccessState(booking: response.data!));
      } else {
        emit(FetchBookingoverviewErrorState(message: response.message));
      }
    } catch (e) {
      FetchBookingoverviewErrorState(message: e.toString());
    }
  }
}
