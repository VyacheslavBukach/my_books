import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_books_usecase.dart';

part 'favourite_books_event.dart';
part 'favourite_books_state.dart';

class FavouriteBooksBloc
    extends Bloc<FavouriteBooksEvent, FavouriteBooksState> {
  final GetFavouriteBooksUseCase getFavouriteBooksUseCase;

  FavouriteBooksBloc({required this.getFavouriteBooksUseCase})
      : super(InitialState()) {
    on<InitialEvent>((event, emit) async {
      var stream = getFavouriteBooksUseCase.getFavouriteBooks();
      emit(ShowingBooksState(bookStream: stream));
    });
  }
}
