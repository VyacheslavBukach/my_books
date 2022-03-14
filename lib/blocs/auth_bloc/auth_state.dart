part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState(this.error);

  final String error;
}
