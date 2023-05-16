import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_car/application/error/resetPasswordFailure.dart';
import 'package:formz/formz.dart';

import '../../../../../models/entities/signUp/email_model.dart';
import '../../../../../models/repository/repository_auth.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  ResetCubit({required this.authenticationRepository}) : super(const ResetState());

  final AuthenticationRepositoryImplementation authenticationRepository;

  void onEmailChange(String value){
    final email = Email.dirty(value);
    emit(
    state.copyWith(
      email: email,
      formState: FormzSubmissionStatus.initial,
      status: Formz.validate([email])));

  }

  Future<void> sendResetCode() async {
    if (!state.status) return;
    emit(state.copyWith(formState: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.resetPassword(email: state.email.value);
      emit(state.copyWith(formState: FormzSubmissionStatus.success));
    } on ResetPasswordFailure catch (e) {
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
