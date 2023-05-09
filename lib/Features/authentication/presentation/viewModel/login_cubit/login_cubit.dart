import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_impl.dart';
import '../../../../../application/error/signInFailure.dart';
import '../../../models/entities/email_model.dart';
import '../../../models/entities/password_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepositoryImplementation _authenticationRepository;

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

}