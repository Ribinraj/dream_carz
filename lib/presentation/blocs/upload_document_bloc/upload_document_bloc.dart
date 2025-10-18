import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/upload_documentmodel.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'upload_document_event.dart';
part 'upload_document_state.dart';

class UploadDocumentBloc extends Bloc<UploadDocumentEvent, UploadDocumentState> {
  final Apprepo repository; 
  UploadDocumentBloc({required this.repository}) : super(UploadDocumentInitial()) {
    on<UploadDocumentEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UploadDocumentButtonClickEvent>(uploaddocument);
  }

  FutureOr<void> uploaddocument(UploadDocumentButtonClickEvent event, Emitter<UploadDocumentState> emit)async {
    emit(UploadDocumentLoadingState());
    try {
      final response= await repository.uploadDocuments(documents: event.documents);
      if (!response.error && response.status==200) {
        emit(UploadDocumentSuccessState(message:response.message));
      }else{
        emit(UploadDocumentErrorState(message: response.message));
      }
    } catch (e) {
      emit(UploadDocumentErrorState(message: e.toString()));
    }
  }
}
