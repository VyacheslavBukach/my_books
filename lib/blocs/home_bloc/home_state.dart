part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class LoadingState extends HomeState {}

class AuthenticatedState extends HomeState {}

class UnauthenticatedState extends HomeState {}

class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);
}
