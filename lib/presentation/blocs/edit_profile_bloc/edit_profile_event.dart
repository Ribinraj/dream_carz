part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class EditProfileButtonClickEvent extends EditProfileEvent {
  final EditProfileModel profile;

  EditProfileButtonClickEvent({required this.profile});
}
