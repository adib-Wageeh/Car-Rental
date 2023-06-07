import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rent_car/models/repository/CarRepository.dart';
import '../../../../../main.dart';
import '../../../../../models/repository/image_picker.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit({
  required this.repositoryImagePicker
  }) :super(AddCarInitial());

  final RepositoryImagePicker repositoryImagePicker;
   String carName="";
   String description="";
   String location="";
   double price=0;
   List<Uint8List?>? images=[];

  Future<void> addCar()async{

    if(images == null)
      {
        emit(AddCarError(error: "please add at least 1 image"));
      }else {
      emit(AddCarLoading());
      await getIt<CarRepository>().addCarOffer(
          carName, description, price, images,location);
      emit(AddCarSuccessfully());
    }
  }

  Future<void> pickImages()async{

    images = await repositoryImagePicker.pickMultipleImageFunction();
  }

}
