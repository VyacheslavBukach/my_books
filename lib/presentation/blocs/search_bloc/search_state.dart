part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSuccessState extends SearchState {
  final Stream<List<Book>> bookStream;

  SearchSuccessState({required this.bookStream});
}

class SearchFailureState extends SearchState {
  final String error;

  SearchFailureState({required this.error});
}
