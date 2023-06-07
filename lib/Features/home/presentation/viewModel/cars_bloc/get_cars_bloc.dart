import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_car/models/entities/car_entity.dart';
import 'package:rent_car/models/repository/CarRepository.dart';
import '../../../../../main.dart';

part 'get_cars_event.dart';
part 'get_cars_state.dart';

class GetCarsBloc extends Bloc<GetCarsEvent, GetCarsState> {
  GetCarsBloc() : carRepository = CarRepository(),
        super(GetCarsInitial()) {
    on<GetFirstCarsEvent>(fetchFirstList);
    on<GetNextCarsEvent>(fetchNextCars);
  }

  StreamController<List<CarEntity>> carsController = StreamController<List<CarEntity>>.broadcast();

  CarRepository carRepository;
  List<CarEntity> carsList=[];
  Stream<List<CarEntity>> get carsStream => carsController.stream;
  late QuerySnapshot<Map<String, dynamic>> documentSnapShot;
  bool isGettingNext = false;
  bool isUp = false;
  bool isDown = false;


  void fetchFirstList(GetFirstCarsEvent event,Emitter<GetCarsState> emit ) async {
    emit(GetCarsLoading());
    QuerySnapshot<Map<String, dynamic>> document;
    if(isUp == true || isDown == true){
      document = await getIt<CarRepository>().getSortedFirstCarsDocuments((isUp)?1:2);
    }else{
      document = await getIt<CarRepository>().getFirstCarsDocuments();
    }
   carsList = await getIt<CarRepository>().getFirstCars(document);
    documentSnapShot = document;
    carsController.sink.add(carsList);
    emit(GetCarsLoaded());
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextCars(GetNextCarsEvent event,Emitter<GetCarsState> emit) async {
    if(isGettingNext)return;
    isGettingNext = true;
    QuerySnapshot<Map<String, dynamic>> document;
    if(isUp == true || isDown == true) {
      document = await getIt<CarRepository>().getNextSortedCarsDocs((isUp)?1:2,documentSnapShot);
    }else{
      document = await getIt<CarRepository>().getNextCarsDocs(documentSnapShot);
    }
      if(document.size == 0){
       emit(GetCarsEnded());
      }else {
        List<CarEntity> newCarsList = await getIt<CarRepository>().getFirstCars(document);
        carsList.addAll(newCarsList);
        documentSnapShot = document;
        carsController.sink.add(carsList);
      }
    isGettingNext = false;
  }


  Future<void> dispose() async{
   await carsController.close();
    // showIndicatorController.close();
  }

}
