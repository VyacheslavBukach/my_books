part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class InitialState extends HomeState {}

class AuthenticatedState extends HomeState {
  final Future<List<Book>> popularBooks;
  final Future<List<Book>> releaseBooks;

  AuthenticatedState({
    required this.popularBooks,
    required this.releaseBooks,
  });
}

class UnauthenticatedState extends HomeState {}

class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);
}
