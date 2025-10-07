import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/coupen_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'coupen_event.dart';
part 'coupen_state.dart';

class CoupenBloc extends Bloc<CoupenEvent, CoupenState> {
  final Apprepo repository;
  CoupenBloc({required this.repository}) : super(CoupenInitial()) {
    on<CoupenEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CoupenButtonClickEvent>(applycoupen);
  }

  FutureOr<void> applycoupen(
    CoupenButtonClickEvent event,
    Emitter<CoupenState> emit,
  ) async {
    emit(CoupenLoadingState());
    try {
      final response = await repository.applycoupen(
        coupencode: event.coupencode,
      );
      if (!response.error && response.status == 200) {
        emit(CoupenSuccessState(coupen: response.data!));
      } else {
        emit(CoupenErrorState(message: response.message));
      }
    } catch (e) {
      emit(CoupenErrorState(message: e.toString()));
    }
  }
}
