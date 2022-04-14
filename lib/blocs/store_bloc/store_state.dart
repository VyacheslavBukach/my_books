part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class InitialState extends StoreState {}

class DefaultStoreState extends StoreState {
  final Stream<List<Book>> bookStream;

  DefaultStoreState({required this.bookStream});
}

class FilteredStoreState extends StoreState {
  final Stream<List<Book>> bookStream;

  FilteredStoreState({required this.bookStream});
}
