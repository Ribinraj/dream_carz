part of 'upload_document_bloc.dart';

@immutable
sealed class UploadDocumentState {}

final class UploadDocumentInitial extends UploadDocumentState {}
final class UploadDocumentLoadingState extends UploadDocumentState{

}
final class UploadDocumentSuccessState extends UploadDocumentState{
  final String message;

  UploadDocumentSuccessState({required this.message});
}
final class UploadDocumentErrorState extends UploadDocumentState{
  final String message;

  UploadDocumentErrorState({required this.message});
}
