import 'package:rent_car/Features/authentication/models/repository/repository_fireStore.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';

import '../Features/authentication/models/repository/image_picker.dart';
import '../Features/authentication/models/repository/repository_auth.dart';
import '../main.dart';



void init(){

  getIt.registerSingleton<AuthenticationRepositoryImplementation>(AuthenticationRepositoryImplementation());
  getIt.registerSingleton<RepositoryImagePicker>(RepositoryImagePicker());
  getIt.registerSingleton<FireStoreRepositoryImplementation>(FireStoreRepositoryImplementation());


}