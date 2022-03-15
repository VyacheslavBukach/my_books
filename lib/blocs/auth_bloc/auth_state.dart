part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}
