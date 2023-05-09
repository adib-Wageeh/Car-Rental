part of 'sign_up_cubit.dart';


class SignUpState extends Equatable {

   const SignUpState({
    this.isObscure=true,
    this.formState=FormzSubmissionStatus.initial,
    this.status=false,
    this.email=const Email.pure(),
    this.password= const Password.pure(),
    this.errorMessage,
    required this.rePassword,
    this.image,
    this.isObscure2=true
});

  final Email email;
  final Password password;
  final RePassword rePassword;
  final bool status;
  final bool isObscure;
  final bool isObscure2;
  final String? errorMessage;
  final Image? image;
  final FormzSubmissionStatus formState;

  @override
  // TODO: implement props
  List<Object?> get props => [isObscure2,email,password,rePassword,status,isObscure,errorMessage,image,formState];


  SignUpState copyWith({
    Email? email,
    Password? password,
    bool? status,
    FormzSubmissionStatus? formState,
    String? errorMessage,
    bool? isObscure,
    RePassword? rePassword,
    Image? image,
    bool? isObscure2
  }) {
    return SignUpState(
      isObscure2: isObscure2??this.isObscure2,
      isObscure: isObscure ?? this.isObscure,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      formState: formState ?? this.formState,
      errorMessage: errorMessage ?? this.errorMessage,
      rePassword: rePassword?? this.rePassword,
      image: image?? this.image
    );
  }

}
