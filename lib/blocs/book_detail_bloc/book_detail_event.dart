part of 'book_detail_bloc.dart';

@immutable
abstract class BookDetailEvent {}

class InitialEvent extends BookDetailEvent {
  final String id;

  InitialEvent({required this.id});
}

class LikedEvent extends BookDetailEvent {
  final String bookID;

  LikedEvent({required this.bookID});
}

class UnlikedEvent extends BookDetailEvent {
  final String bookID;

  UnlikedEvent({required this.bookID});
}
