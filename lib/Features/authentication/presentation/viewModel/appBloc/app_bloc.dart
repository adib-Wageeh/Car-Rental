import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_car/models/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/repository/repository_auth.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepositoryImplementation authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
        authenticationRepository.currentUser.isNotEmpty
            ? (FirebaseAuth.instance.currentUser!.emailVerified)?const AppState.authenticated():const AppState.authenticatedUnVerifiedEmail()
            : const AppState.unauthenticated(),
      ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    userSubscription = _authenticationRepository.user.listen(
          (user) {
            add(_AppUserChanged(user));
            },
    );
  }

  final AuthenticationRepositoryImplementation _authenticationRepository;
  late final StreamSubscription<User?> userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async{

    if(event.user == null){
    final result = await checkOnBoarding(emit);
    if(result == 1){
      emit(const AppState.firstUnauthenticated());
    }else{
      emit(const AppState.unauthenticated());
    }
    }else{
      if(event.user!.emailVerified) {

        emit(const AppState.authenticated());
      }else{
        emit(const AppState.authenticatedUnVerifiedEmail());
      }

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
    userSubscription.cancel();
    return super.close();
  }
}