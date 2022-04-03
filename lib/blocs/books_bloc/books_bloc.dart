import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_book_stream_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_books_usecase.dart';

import '../../domain/entities/book.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetFavouriteBookStreamUseCase getFavouriteBookStreamUseCase;

  BooksBloc({
    required this.getFavouriteBookStreamUseCase,
  }) : super(ShowingBooksState()) {
    on<InitialBooksEvent>((event, emit) async {
      // try {
      //   var books = getFavouriteBookStreamUseCase.getFavouriteBookStream();
      // emit(ShowingBooksState());
      // } catch (e) {
      //   emit(ErrorBooksState(e.toString()));
      // }
    });
  }
}
