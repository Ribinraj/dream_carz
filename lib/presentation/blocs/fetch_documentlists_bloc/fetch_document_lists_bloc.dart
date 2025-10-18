import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/documentlist_model.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_document_lists_event.dart';
part 'fetch_document_lists_state.dart';

class FetchDocumentListsBloc extends Bloc<FetchDocumentListsEvent, FetchDocumentListsState> {
  final Apprepo repository;
  FetchDocumentListsBloc({required this.repository}) : super(FetchDocumentListsInitial()) {
    on<FetchDocumentListsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDocmentsButtonClickEvent>(fetchdocuments);
  }

  FutureOr<void> fetchdocuments(FetchDocmentsButtonClickEvent event, Emitter<FetchDocumentListsState> emit) async{
    emit(FetchDocumentsLoadingState());
    try {
       final response= await repository.fetchdocumenlists(bookingId: event.bookingId);
       if (!response.error && response.status==200) {
         emit(FetchDocumentsSuccessState(documents: response.data!));
       }
       else{
        emit(FetchDocumentsErrorState(message: response.message));
       }
    } catch (e) {
      emit(FetchDocumentsErrorState(message: e.toString()));
    }
  }
}
