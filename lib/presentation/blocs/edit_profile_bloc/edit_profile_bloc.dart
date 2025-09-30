import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/edit_profile_model.dart';
import 'package:dream_carz/domain/repositories/loginrepo.dart';
import 'package:flutter/material.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final Loginrepo repository;
  EditProfileBloc({required this.repository}) : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EditProfileButtonClickEvent>(editprofile);
  }

  FutureOr<void> editprofile(
    EditProfileButtonClickEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoadingState());
    try {
      final responase = await repository.updateprofile(profile: event.profile);
      if (!responase.error && responase.status == 200) {
        emit(EditProfileSuccessState(message: responase.message));
      } else {
        emit(EditProfileErrorState(message: responase.message));
      }
    } catch (e) {
           emit(EditProfileErrorState(message:e.toString()));
    }
  }
}
