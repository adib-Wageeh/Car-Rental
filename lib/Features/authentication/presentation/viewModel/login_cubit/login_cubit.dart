import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_auth.dart';
import '../../../../../application/error/signInFailure.dart';
import '../../../../../application/error/signInWithGoogleFailure.dart';
import '../../../models/entities/email_model.dart';
import '../../../models/entities/password_model.dart';
import '../../../models/repository/repository_fireStore.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository,this.fireStoreRepositoryImplementation) : super(const LoginState());

  final AuthenticationRepositoryImplementation _authenticationRepository;
  final FireStoreRepositoryImplementation fireStoreRepositoryImplementation;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([email, state.password]) ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([state.email, password],
        ),
      ),
    );
  }

  void obscureChange(){
    LoginState appState = state.copyWith(isObscure: !(state.isObscure),
    formState: FormzSubmissionStatus.initial
    );
    emit(appState);
  }

  Future<void> logInWithCredentials() async {
    if (!state.status) return;
    emit(state.copyWith(formState: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      // fireStoreRepositoryImplementation.saveToCache(_authenticationRepository.currentUser.id);
      emit(state.copyWith(formState: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          formState: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(formState: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(formState: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(formState: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          formState: FormzSubmissionStatus.failure,
        ),
      );
    } catch (e) {
      emit(state.copyWith(formState: FormzSubmissionStatus.failure,
      errorMessage: e.toString()
      ));
    }
  }

}