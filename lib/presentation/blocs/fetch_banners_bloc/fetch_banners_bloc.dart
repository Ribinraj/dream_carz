import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dream_carz/data/banner_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_banners_event.dart';
part 'fetch_banners_state.dart';

class FetchBannersBloc extends Bloc<FetchBannersEvent, FetchBannersState> {
  final Apprepo repository;
  FetchBannersBloc({required this.repository}) : super(FetchBannersInitial()) {
    on<FetchBannersEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchBannersInitialEvnt>(fetchbanner);
  }

  FutureOr<void> fetchbanner(
    FetchBannersInitialEvnt event,
    Emitter<FetchBannersState> emit,
  ) async {
    emit(FetchBannersLoadingState());
    try {
      final response = await repository.fetchbanners();
      if (!response.error && response.status == 200) {
        emit(FetchBannersSuccessState(banners: response.data!));
      } else {
        emit(FetchBannersErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchBannersErrorState(message: e.toString()));
    }
  }
}
