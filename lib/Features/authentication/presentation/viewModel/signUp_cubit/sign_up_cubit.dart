import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_impl.dart';
import 'package:rent_car/application/error/signUpFailure.dart';
import '../../../models/entities/email_model.dart';
import '../../../models/entities/password_model.dart';
import '../../../models/entities/re_password_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationRepository}) :
        super(const SignUpState(rePassword: RePassword.pure(password: "")));

  final AuthenticationRepositoryImplementation authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
          email: email,
          formState: FormzSubmissionStatus.initial,
          status: Formz.validate([email,state.rePassword,state.password]) ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    // RePassword.pure(password: password.value);
    emit(
      state.copyWith(
        password: password,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([state.email,state.rePassword, password]),
      ),
    );
  }

  void password2Changed(String value) {
    final password = RePassword.dirty(value,state.password.value);
    emit(
      state.copyWith(
        rePassword: password,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([state.email,password, state.password]),
      ),
    );
  }

  void obscureChange(){
    SignUpState appState = state.copyWith(isObscure: !(state.isObscure),
      formState: FormzSubmissionStatus.initial,
    );
    emit(appState,);
  }
  void obscure2Change(){
    SignUpState appState = state.copyWith(isObscure2: !(state.isObscure2),
      formState: FormzSubmissionStatus.initial,
    );
    emit(appState,);
  }

  Future<void> signUpWithCredentials() async {
    if (!state.status) return;
    emit(state.copyWith(formState: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(formState: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
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
