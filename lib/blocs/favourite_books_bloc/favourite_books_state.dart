part of 'favourite_books_bloc.dart';

@immutable
abstract class FavouriteBooksState {}

class InitialState extends FavouriteBooksState {}

class ShowingBooksState extends FavouriteBooksState {
  final Stream<List<Book>> bookStream;

  ShowingBooksState({required this.bookStream});
}

// class ErrorBooksState extends BooksState {
//   final String error;
//
//   ErrorBooksState(this.error);
// }
