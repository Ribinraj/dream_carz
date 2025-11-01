part of 'delete_account_bloc.dart';

@immutable
sealed class DeleteAccountEvent {}
final class DeleteButtonClickEvent extends DeleteAccountEvent {
  final String reason;

  DeleteButtonClickEvent({required this.reason});
}