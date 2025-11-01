import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/domain/repositories/loginrepo.dart';
import 'package:meta/meta.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final Loginrepo repository;
  DeleteAccountBloc({required this.repository})
    : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DeleteButtonClickEvent>(deleteaccount);
  }

  FutureOr<void> deleteaccount(
    DeleteButtonClickEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoadingState());
    try {
      final response = await repository.deleteaccount(reason: event.reason);
      if (!response.error && response.status == 200) {
        emit(DeleteAccountSuccessState(message: response.message));
      }
    } catch (e) {
       emit(DeleteAccountSuccessState(message:e.toString()));
    }
  }
}