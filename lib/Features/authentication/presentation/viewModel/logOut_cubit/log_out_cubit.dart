import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_impl.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.authenticationRepositoryImplementation) : super(LogOutInitial());
  final AuthenticationRepositoryImplementation authenticationRepositoryImplementation;

  void logOut(){

      authenticationRepositoryImplementation.logOut();
  }

}
