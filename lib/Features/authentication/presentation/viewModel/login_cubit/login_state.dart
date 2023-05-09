part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = false,
    this.errorMessage,
    this.formState = FormzSubmissionStatus.initial,
    this.isObscure = true
  });

  final Email email;
  final Password password;
  final bool status;
  final bool isObscure;
  final String? errorMessage;
  final FormzSubmissionStatus formState;

  @override
  List<Object?> get props => [formState,isObscure,email, password, status, errorMessage];

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? status,
    FormzSubmissionStatus? formState,
    String? errorMessage,
    bool? isObscure
  }) {
    return LoginState(
      isObscure: isObscure ?? this.isObscure,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      formState: formState ?? this.formState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}