import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/city_model.dart';
import 'package:dream_carz/domain/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_cities_event.dart';
part 'fetch_cities_state.dart';

class FetchCitiesBloc extends Bloc<FetchCitiesEvent, FetchCitiesState> {
  final Apprepo repository;
  FetchCitiesBloc({required this.repository}) : super(FetchCitiesInitial()) {
    on<FetchCitiesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchcitiesInitialEvent>(fetchcities);
  }

  FutureOr<void> fetchcities(
    FetchcitiesInitialEvent event,
    Emitter<FetchCitiesState> emit,
  ) async {
    emit(FetchCitiesLoadingState());
    try {
      final response = await repository.fetchcities();
      if (!response.error && response.status == 200) {
        emit(FetchCitiesSuccessState(cities: response.data!));
      } else {
        emit(FetchCitiesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchCitiesErrorState(message: e.toString()));
    }
  }
}
