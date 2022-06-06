part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class AuthenticatedState extends LoginState {}

class UnauthenticatedState extends LoginState {
  final bool loading;

  UnauthenticatedState({required this.loading});
}

class AuthErrorState extends LoginState {
  final String error;

  AuthErrorState(this.error);
}
