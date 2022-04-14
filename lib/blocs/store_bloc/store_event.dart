part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class FilterByDefaultEvent extends StoreEvent {}

class FilterByGenresEvent extends StoreEvent {
  final List<String> genres;

  FilterByGenresEvent({required this.genres});
}
