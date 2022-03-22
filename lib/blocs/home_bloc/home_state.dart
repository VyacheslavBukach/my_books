part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class LoadingState extends HomeState {}

class AuthenticatedState extends HomeState {}

class UnauthenticatedState extends HomeState {}

class AuthErrorState extends HomeState {
  final String error;

  AuthErrorState(this.error);
}
