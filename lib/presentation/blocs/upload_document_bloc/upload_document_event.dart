part of 'upload_document_bloc.dart';

@immutable
sealed class UploadDocumentEvent {}
final class UploadDocumentButtonClickEvent extends UploadDocumentEvent{
  final UploadDocumentmodel documents;

  UploadDocumentButtonClickEvent({required this.documents});
}