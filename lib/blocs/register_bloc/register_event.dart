part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SignInEvent extends RegisterEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends RegisterEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}

class SignOutEvent extends RegisterEvent {}
