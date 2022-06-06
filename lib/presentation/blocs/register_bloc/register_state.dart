part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class AuthenticatedState extends RegisterState {}

class UnauthenticatedState extends RegisterState {
  final bool loading;

  UnauthenticatedState({required this.loading});
}

class AuthErrorState extends RegisterState {
  final String error;

  AuthErrorState(this.error);
}
