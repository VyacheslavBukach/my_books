import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/book.dart';
import '../../domain/usecases/firestore/get_books_from_search_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetBooksFromSearchUseCase getBooksFromSearchUseCase;

  SearchBloc({
    required this.getBooksFromSearchUseCase,
  }) : super(SearchInitial()) {
    on<InitialSearchEvent>((event, emit) async {
      try {
        var stream = getBooksFromSearchUseCase.getBooksFromSearch(event.query);
        emit(SearchSuccessState(bookStream: stream));
      } catch (e) {
        emit(SearchFailureState(error: e.toString()));
      }
    });
  }
}
