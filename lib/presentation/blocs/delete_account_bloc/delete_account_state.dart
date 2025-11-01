part of 'delete_account_bloc.dart';

@immutable
sealed class DeleteAccountState {}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoadingState extends DeleteAccountState {}

final class DeleteAccountSuccessState extends DeleteAccountState {
  final String message;

  DeleteAccountSuccessState({required this.message});
}

final class DeleteAccountErrorState extends DeleteAccountState {
  final String message;

  DeleteAccountErrorState({required this.message});
}
