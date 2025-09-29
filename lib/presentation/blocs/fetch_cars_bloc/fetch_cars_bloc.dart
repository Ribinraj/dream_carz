import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/cars_model.dart';
import 'package:dream_carz/data/search_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_cars_event.dart';
part 'fetch_cars_state.dart';

class FetchCarsBloc extends Bloc<FetchCarsEvent, FetchCarsState> {
  final Apprepo repository;
  FetchCarsBloc({required this.repository}) : super(FetchCarsInitial()) {
    on<FetchCarsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchCarsButtonClickEvent>(fetchcars);
  }

  FutureOr<void> fetchcars(
    FetchCarsButtonClickEvent event,
    Emitter<FetchCarsState> emit,
  ) async {
    emit(FetchCarsLoadingState());
    try {
      final response = await repository.fetchedCars(search: event.search);
      if (!response.error && response.status == 200) {
        emit(FetchCarsSuccessState(cars: response.data!));
      } else {
        emit(FetchCarsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchCarsErrorState(message: e.toString()));
    }
  }
}
