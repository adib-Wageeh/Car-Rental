import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';

import '../../../../../models/entities/user_entity.dart';

part 'car_description_state.dart';

class CarDescriptionCubit extends Cubit<CarDescriptionState> {
  CarDescriptionCubit({required this.fireStoreRepositoryImplementation}) : super(CarDescriptionInitial());

  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;


  Future<UserEntity> getCarSeller(String sellerUid)async{

    return await fireStoreRepositoryImplementation.getCarSeller(sellerUid);

    }


}
