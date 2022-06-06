part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}
