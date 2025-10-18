part of 'fetch_document_lists_bloc.dart';

@immutable
sealed class FetchDocumentListsState {}

final class FetchDocumentListsInitial extends FetchDocumentListsState {}
final class FetchDocumentsLoadingState extends FetchDocumentListsState{}
final class FetchDocumentsSuccessState extends FetchDocumentListsState{
  final List <DocumentlistModel > documents;

  FetchDocumentsSuccessState({required this.documents});
}
final class FetchDocumentsErrorState extends FetchDocumentListsState{
  final String message;

  FetchDocumentsErrorState({required this.message});
}