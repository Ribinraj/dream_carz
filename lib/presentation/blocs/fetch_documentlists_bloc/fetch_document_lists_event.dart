part of 'fetch_document_lists_bloc.dart';

@immutable
sealed class FetchDocumentListsEvent {}
final class FetchDocmentsButtonClickEvent extends FetchDocumentListsEvent{
  final String bookingId;

  FetchDocmentsButtonClickEvent({required this.bookingId});
}