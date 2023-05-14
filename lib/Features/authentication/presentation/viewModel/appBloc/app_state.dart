part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  authenticatedUnVerifiedEmail,
  unauthenticated,
  firstUnauthenticated
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    // this.user = UserEntity.empty,
  });

  const AppState.authenticated()
      : this._(status: AppStatus.authenticated);

  const AppState.authenticatedUnVerifiedEmail()
      : this._(status: AppStatus.authenticatedUnVerifiedEmail);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.firstUnauthenticated() : this._(status: AppStatus.firstUnauthenticated);

  final AppStatus status;

  @override
  List<Object> get props => [status];
}