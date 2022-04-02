import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_books_usecase.dart';

import '../../domain/entities/book.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetFavouriteBooksUseCase getFavouriteBooksUseCase;

  BooksBloc({
    required this.getFavouriteBooksUseCase,
  }) : super(LoadingBooksState()) {
    on<InitialBooksEvent>((event, emit) async {
      try {
        var books = await getFavouriteBooksUseCase.getFavouriteBooks();
        emit(SuccessBooksState(books: books));
      } catch (e) {
        emit(ErrorBooksState(e.toString()));
      }
    });
  }
}
