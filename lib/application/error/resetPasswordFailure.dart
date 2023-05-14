class ResetPasswordFailure implements Exception {
  const ResetPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory ResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const ResetPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'missing-android-pkg-name':
        return const ResetPasswordFailure(
          'An Android package name must be provided if the Android app is required to be installed',
        );
      case 'missing-continue-uri':
        return const ResetPasswordFailure(
          'A continue URL must be provided in the request',
        );
      case 'invalid-continue-uri':
        return const ResetPasswordFailure(
          'Incorrect password, please try again.',
        );
      case 'user-not-found':
        return const ResetPasswordFailure(
          'Email does not exist',
        );
      default:
        return const ResetPasswordFailure();
    }
  }

  final String message;
}