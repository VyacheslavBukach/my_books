part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class DefaultStoreState extends StoreState {}

class FilteredStoreState extends StoreState {
  final List<String> genres;

  FilteredStoreState({required this.genres});
}
