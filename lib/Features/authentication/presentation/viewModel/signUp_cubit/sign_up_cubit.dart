import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/application/error/signUpFailure.dart';

import '../../../../../models/entities/signUp/email_model.dart';
import '../../../../../models/entities/signUp/name_model.dart';
import '../../../../../models/entities/signUp/password_model.dart';
import '../../../../../models/entities/signUp/re_password_model.dart';
import '../../../../../models/repository/image_picker.dart';
import '../../../../../models/repository/repository_auth.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationRepository,
  required this.imagePickerRepo,
  }) :
        super(const SignUpState(rePassword: RePassword.pure(password: ""),
      name: NameModel.pure()
      ));

  final AuthenticationRepositoryImplementation authenticationRepository;
  final RepositoryImagePicker imagePickerRepo;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
          email: email,
          formState: FormzSubmissionStatus.initial,
          status: Formz.validate([email,state.rePassword,state.password,state.name]) ),
    );
  }

  void nameChanged(String value) {
    final name = NameModel.dirty(value);
    emit(
      state.copyWith(
          name: name,
          formState: FormzSubmissionStatus.initial,
          status: Formz.validate([name,state.email,state.rePassword,state.password]) ),
    );
  }


  void passwordChanged(String value) {
    final password = Password.dirty(value);
    // RePassword.pure(password: password.value);
    emit(
      state.copyWith(
        password: password,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([state.email,state.rePassword,state.name, password]),
      ),
    );
  }

  void password2Changed(String value) {
    final password = RePassword.dirty(value,state.password.value);
    emit(
      state.copyWith(
        rePassword: password,
        formState: FormzSubmissionStatus.initial,
        status: Formz.validate([state.email,password,state.name, state.password]),
      ),
    );
  }

  Future<void> setImage(Uint8List image)async{

     emit(state.copyWith(
       imagePath: image,
       formState: FormzSubmissionStatus.initial,
     ));
  }


  Future<Uint8List?> getImage()async{

    final res = await imagePickerRepo.pickImageFunction();
    if(res != null){
      return res;
    }
    return null;
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
    if (state.imagePath== null){
      emit(state.copyWith(errorMessage: "please select an image",formState: FormzSubmissionStatus.failure));
      return;
    }
    emit(state.copyWith(formState: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        name: state.name.value,
        imagePath: state.imagePath!
      );
      await sendVerificationCode();
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

  void clearState(){
    emit(const SignUpState(name: NameModel.pure(), rePassword: RePassword.pure(password: "")));
  }

  Future<void> sendVerificationCode()async{

   await authenticationRepository.sendEmailVerificationCode();
  }

}
