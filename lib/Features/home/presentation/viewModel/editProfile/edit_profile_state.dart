part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileDone extends EditProfileState {}

class EditProfileError extends EditProfileState {}

class EditProfileImageSet extends EditProfileState {

  EditProfileImageSet();
}
