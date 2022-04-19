part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class InitialState extends HomeState {}

class AuthenticatedState extends HomeState {
  final Future<List<Book>> popularStream;
  final Future<List<Book>> releasesStream;
  final String email;

  AuthenticatedState({
    required this.email,
    required this.popularStream,
    required this.releasesStream,
  });
}

class UnauthenticatedState extends HomeState {}

class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);
}
