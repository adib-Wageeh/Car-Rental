part of 'reset_cubit.dart';


class ResetState extends Equatable {

  final bool status;
  final FormzSubmissionStatus formState;
  final Email email;
  final String errorMessage;
  const ResetState({this.formState=FormzSubmissionStatus.initial
    ,this.status = false,
    this.errorMessage = "",
  this.email = const Email.pure()
  });

  @override
  List<Object?> get props => [errorMessage,email,formState,status];

  ResetState copyWith({bool? status,FormzSubmissionStatus? formState,String? errorMessage, Email? email}){
    return ResetState(formState: formState??this.formState,
        status: status??this.status,email: email??this.email,errorMessage: errorMessage??this.errorMessage
    );
  }


}
