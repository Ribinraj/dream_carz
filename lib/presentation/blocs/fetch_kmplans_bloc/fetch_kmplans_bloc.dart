import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/km_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_kmplans_event.dart';
part 'fetch_kmplans_state.dart';

class FetchKmplansBloc extends Bloc<FetchKmplansEvent, FetchKmplansState> {
  final Apprepo repository;
  FetchKmplansBloc({required this.repository}) : super(FetchKmplansInitial()) {
    on<FetchKmplansEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchKmplansInitialEvent>(fetchkmplans);
  }

  FutureOr<void> fetchkmplans(
    FetchKmplansInitialEvent event,
    Emitter<FetchKmplansState> emit,
  ) async {
    emit(FetchKmplansLoadingState());
    try {
      final response = await repository.fetchkmplans();
      if (!response.error && response.status == 200) {
        emit(FetchKmplansSuccessState(kmplans: response.data!));
      } else {
        emit(FetchKmplansErrorState(message: response.message));
      }
    } catch (e) {
       emit(FetchKmplansErrorState(message:e.toString()));
    }
  }
}
