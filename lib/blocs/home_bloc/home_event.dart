part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SignOutEvent extends HomeEvent {}

class BookClickedEvent extends HomeEvent {
  final String bookID;

  BookClickedEvent({required this.bookID});
}
