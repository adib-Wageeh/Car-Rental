part of 'sign_up_cubit.dart';


class SignUpState extends Equatable {

   const SignUpState({
    this.isObscure=true,
    this.formState=FormzSubmissionStatus.initial,
    this.status=false,
    this.email=const Email.pure(),
    this.password= const Password.pure(),
    this.errorMessage,
    required this.name,
    required this.rePassword,
    this.imagePath,
    this.isObscure2=true
});

  final Email email;
  final Password password;
  final RePassword rePassword;
  final NameModel name;
  final bool status;
  final bool isObscure;
  final bool isObscure2;
  final String? errorMessage;
  final Uint8List? imagePath;
  final FormzSubmissionStatus formState;

  @override
  // TODO: implement props
  List<Object?> get props => [name,isObscure2,email,password,rePassword,status,isObscure,errorMessage,imagePath,formState];


  SignUpState copyWith({
    Email? email,
    NameModel? name,
    Password? password,
    bool? status,
    FormzSubmissionStatus? formState,
    String? errorMessage,
    bool? isObscure,
    RePassword? rePassword,
    Uint8List? imagePath,
    bool? isObscure2
  }) {
    return SignUpState(
      name: name??this.name,
      isObscure2: isObscure2??this.isObscure2,
      isObscure: isObscure ?? this.isObscure,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      formState: formState ?? this.formState,
      errorMessage: errorMessage ?? this.errorMessage,
      rePassword: rePassword?? this.rePassword,
      imagePath: imagePath?? this.imagePath
    );
  }

}
