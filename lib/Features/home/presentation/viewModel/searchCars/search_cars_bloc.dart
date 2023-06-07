import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../models/entities/car_entity.dart';
import '../../../../../models/repository/CarRepository.dart';

part 'search_cars_event.dart';
part 'search_cars_state.dart';

class SearchCarsBloc extends Bloc<SearchCarsEvent, SearchCarsState> {
  SearchCarsBloc() : super(SearchCarsInitial()) {
    on<EditSearchCarsEvent>(fetchSearchData);
  }

  StreamController<List<CarEntity>> carsController = StreamController<List<CarEntity>>.broadcast();
  Stream<List<CarEntity>> get carsStream => carsController.stream;
  bool isEmpty = false;


  void fetchSearchData(EditSearchCarsEvent event,Emitter<SearchCarsState> emit ) async {
      isEmpty = false;

      emit(SearchCarsLoading());
      List<CarEntity> cars = await getIt<CarRepository>().searchForCars(event.text);
      if(cars.isEmpty){
      isEmpty = true;
      emit(SearchCarsEmpty());
      }else {
        carsController.sink.add(cars);
        emit(SearchCarsLoaded());
      }

  }


}
