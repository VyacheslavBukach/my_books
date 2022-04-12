part of 'favourite_books_bloc.dart';

@immutable
abstract class FavouriteBooksState {}

// class LoadingBooksState extends BooksState {}

class ShowingBooksState extends FavouriteBooksState {
  // final List<Book> books;
  //
  // SuccessBooksState({required this.books});
}

// class ErrorBooksState extends BooksState {
//   final String error;
//
//   ErrorBooksState(this.error);
// }
