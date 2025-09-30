part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {
  final String message;

  EditProfileSuccessState({required this.message});
}

final class EditProfileErrorState extends EditProfileState {
  final String message;

  EditProfileErrorState({required this.message});
}
