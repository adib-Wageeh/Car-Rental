import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalid
}

class RePassword extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const RePassword.pure({required this.password}) : super.pure('');
  final String? password;

  /// {@macro password}
  const RePassword.dirty([super.value = '',this.password]) : super.dirty();


  @override
  PasswordValidationError? validator(String? value) {
    print("val  "+value!);
    print(password);
    return  (value.isNotEmpty && value == password)
        ? null
        : PasswordValidationError.invalid;
  }
}