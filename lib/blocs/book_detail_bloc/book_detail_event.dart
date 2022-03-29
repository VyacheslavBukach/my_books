part of 'book_detail_bloc.dart';

@immutable
abstract class BookDetailEvent {}

class OpenBookDetailEvent extends BookDetailEvent {
  final String id;

  OpenBookDetailEvent({required this.id});
}
