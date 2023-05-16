import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalid
}

class NameModel extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const NameModel.pure() : super.pure('');

  /// {@macro password}
  const NameModel.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp =
  RegExp(r'^[A -Za -z\d]{5,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}