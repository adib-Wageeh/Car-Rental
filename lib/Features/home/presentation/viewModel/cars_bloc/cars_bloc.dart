import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/entities/car_entity.dart';

import '../../../../../models/repository/repository_fireStore.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc({required this.fireStoreRepositoryImplementation}) : super(CarsInitial()) {
    on<GetData>((event, emit) async{
      emit(CarsLoading());
      try{
        final data = await fireStoreRepositoryImplementation.getCars();
        print(data);
        emit(CarsLoaded(cars: data));
      }catch(e){
        emit(CarsError(error: e.toString()));
      }


    });
  }




  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;


}
