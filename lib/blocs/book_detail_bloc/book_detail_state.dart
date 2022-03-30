part of 'book_detail_bloc.dart';

@immutable
abstract class BookDetailState {}

class LoadingBookState extends BookDetailState {}

class SuccessBookState extends BookDetailState {
  final Book? book;

  SuccessBookState({required this.book});
}

class ErrorBookState extends BookDetailState {
  final String error;

  ErrorBookState(this.error);
}

class LikeState extends BookDetailState {}

class UnlikeState extends BookDetailState {}
