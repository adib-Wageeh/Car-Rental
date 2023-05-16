import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';

import '../getUserData/get_user_data_cubit.dart';

part 'edit_profile_state.dart';


class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
  required this.getUserDataCubit
  ,required this.fireStoreRepositoryImplementation}) : super(EditProfileInitial());

  GetUserDataCubit getUserDataCubit;
  Uint8List? image;
  String? imagePath;
  TextEditingController nameEditingController = TextEditingController();
  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;

  Future<void> saveData()async {
    if (nameEditingController.text.isEmpty && image == null) {
      emit(EditProfileError());
    } else{
      emit(EditProfileLoading());
      if(nameEditingController.text.isNotEmpty && image == null) {
        await fireStoreRepositoryImplementation.saveNameChanges(
            nameEditingController.text);
      }else if(nameEditingController.text.isEmpty && image != null){
       imagePath = await fireStoreRepositoryImplementation.saveImageChanges(image!);
      }else{
        await fireStoreRepositoryImplementation.saveNameChanges(
            nameEditingController.text);
        imagePath = await fireStoreRepositoryImplementation.saveImageChanges(image!);
      }
      emit(EditProfileDone());
    }
  }

  void setImage(Uint8List imageNew){
    emit(EditProfileLoading());
    image = imageNew;
    emit(EditProfileImageSet());
  }



}
