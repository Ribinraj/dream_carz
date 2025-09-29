import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/categories_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_categories_event.dart';
part 'fetch_categories_state.dart';

class FetchCategoriesBloc
    extends Bloc<FetchCategoriesEvent, FetchCategoriesState> {
  final Apprepo repository;
  FetchCategoriesBloc({required this.repository})
    : super(FetchCategoriesInitial()) {
    on<FetchCategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchCategoreisInitailfetchingEvent>(fetchcategories);
  }

  FutureOr<void> fetchcategories(
    FetchCategoreisInitailfetchingEvent event,
    Emitter<FetchCategoriesState> emit,
  ) async {
    emit(FetchCategoriesLoadingState());
    try {
      final response = await repository.fetchcategories();
      if (!response.error && response.status == 200) {
        emit(FetchCategoriesSuccessState(categories: response.data!));
      } else {
        emit(FetchCategoriesErrorState(message: response.message));
      }
    } catch (e) {
          emit(FetchCategoriesErrorState(message:e.toString()));
    }
  }
}
