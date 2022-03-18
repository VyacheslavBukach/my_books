part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoadingState extends LoginState {}

class AuthenticatedState extends LoginState {}

class UnauthenticatedState extends LoginState {}

class AuthErrorState extends LoginState {
  final String error;

  AuthErrorState(this.error);
}
