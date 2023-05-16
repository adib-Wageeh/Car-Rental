import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_car/models/repository/repository_auth.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit({required this.authenticationRepositoryImplementation})
      : super(const GetUserDataState());

  AuthenticationRepositoryImplementation authenticationRepositoryImplementation;

  void setState(){
    emit(
      state.copyWith(
        imagePath: authenticationRepositoryImplementation.currentUser.photo!,
        name: authenticationRepositoryImplementation.currentUser.name!,
        email: authenticationRepositoryImplementation.currentUser.email
      )
    );
  }

  dataChange(String? name,String? imagePath){
    print(state.name);
    print(imagePath);
    if(name == ""){
      print("jjjjjj");
      emit(state.copyWith(imagePath: imagePath));
    }else if(imagePath == ""){
      emit(state.copyWith(name: name));
    }
    emit(state.copyWith(name: name,imagePath: imagePath));

  }


}
