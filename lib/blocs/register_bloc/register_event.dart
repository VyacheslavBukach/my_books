part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SignUpEvent extends RegisterEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}
