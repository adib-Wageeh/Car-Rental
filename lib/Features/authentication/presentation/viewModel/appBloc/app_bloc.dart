import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/entities/user_entity.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepositoryImplementation authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
        authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated(),
      ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
          (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepositoryImplementation _authenticationRepository;
  late final StreamSubscription<UserEntity> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async{

    if(event.user.isEmpty){
    final result = await checkOnBoarding(emit);
    if(result == 1){
      emit(const AppState.firstUnauthenticated());
    }else{
      emit(const AppState.unauthenticated());
    }
    }else{
      emit(AppState.authenticated(event.user));
    }

  }


  Future<int> checkOnBoarding( Emitter<AppState> emit)async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt("onBoarding")==null){
     await prefs.setInt("onBoarding", 1);
     return 1;
    }else{
     return 2;
     }

  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}