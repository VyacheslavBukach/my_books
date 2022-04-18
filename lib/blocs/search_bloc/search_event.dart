part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class InitialSearchEvent extends SearchEvent {
  final String query;

  InitialSearchEvent({required this.query});
}
