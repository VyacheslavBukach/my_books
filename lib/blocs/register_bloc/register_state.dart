part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class LoadingState extends RegisterState {}

class AuthenticatedState extends RegisterState {}

class UnauthenticatedState extends RegisterState {}

class AuthErrorState extends RegisterState {
  final String error;

  AuthErrorState(this.error);
}
