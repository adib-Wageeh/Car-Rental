
import 'package:rent_car/models/repository/CarRepository.dart';

import '../main.dart';
import '../models/repository/image_picker.dart';
import '../models/repository/repository_auth.dart';
import '../models/repository/repository_fireStore.dart';



void init(){

  getIt.registerSingleton<AuthenticationRepositoryImplementation>(AuthenticationRepositoryImplementation());
  getIt.registerSingleton<RepositoryImagePicker>(RepositoryImagePicker());
  getIt.registerSingleton<CarRepository>(CarRepository());
  getIt.registerSingleton<FireStoreRepositoryImplementation>(FireStoreRepositoryImplementation(authenticationRepositoryImplementation: getIt<AuthenticationRepositoryImplementation>()));


}