part of 'book_detail_bloc.dart';

@immutable
abstract class BookDetailState {}

class InitialState extends BookDetailState {}

class ShowingBookState extends BookDetailState {
  final Book? book;
  final Stream<bool> likeStream;

  ShowingBookState({
    required this.book,
    required this.likeStream,
  });
}

class ErrorBookState extends BookDetailState {
  final String error;

  ErrorBookState(this.error);
}

class LikeState extends BookDetailState {}

class UnlikeState extends BookDetailState {}
