import '../Features/authentication/models/repository/repository_impl.dart';
import '../main.dart';



void init(){

  getIt.registerSingleton<AuthenticationRepositoryImplementation>(AuthenticationRepositoryImplementation());


}