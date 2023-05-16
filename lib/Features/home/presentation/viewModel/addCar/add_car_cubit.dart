import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit({required this.fireStoreRepositoryImplementation}) : super(AddCarInitial());

  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;

  void addCar(String carName,String description,double price,List<Uint8List> images,String sellerId)async{

    emit(AddCarLoading());
    await fireStoreRepositoryImplementation.addCarOffer(carName, description, price, images, sellerId);
    emit(AddCarSuccessfully());

  }

}
