import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/entities/car_entity.dart';

import '../../../../../main.dart';
import '../../../../../models/repository/repository_fireStore.dart';

part 'get_cars_event.dart';
part 'get_cars_state.dart';

class GetCarsBloc extends Bloc<GetCarsEvent, GetCarsState> {
  GetCarsBloc() :super(GetCarsInitial()) {
    on<GetFirstCarsEvent>(fetchFirstList);
    on<GetNextCarsEvent>(fetchNextMovies);
  }

  StreamController<List<CarEntity>> movieController = StreamController<List<CarEntity>>();
  List<CarEntity> carsList=[];
  Stream<List<CarEntity>> get movieStream => movieController.stream;
  late QuerySnapshot<Map<String, dynamic>> documentSnapShot;


  void fetchFirstList(GetFirstCarsEvent event,Emitter<GetCarsState> emit ) async {
    emit(GetCarsLoading());
    QuerySnapshot<Map<String, dynamic>> document = await getIt<FireStoreRepositoryImplementation>().getFirstCarsDocuments();
   carsList = await getIt<FireStoreRepositoryImplementation>().getFirstCars(document);
    documentSnapShot = document;
    movieController.sink.add(carsList);
    emit(GetCarsLoaded());
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextMovies(GetNextCarsEvent event,Emitter<GetCarsState> emit) async {
    // emit(GetNextCarsLoading());
    QuerySnapshot<Map<String, dynamic>> document = await getIt<FireStoreRepositoryImplementation>().getNextCarsDocs(documentSnapShot);
    List<CarEntity> newCarsList = await getIt<FireStoreRepositoryImplementation>().getFirstCars(document);
    carsList.addAll(newCarsList);
    documentSnapShot = document;
    movieController.sink.add(carsList);
    // emit(GetCarsLoaded());
  }

  void dispose() {
    movieController.close();
    // showIndicatorController.close();
  }

}
