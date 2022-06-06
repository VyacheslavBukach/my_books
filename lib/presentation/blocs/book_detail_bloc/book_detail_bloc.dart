import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/usecases/firestore/add_book_to_favourite_usecase.dart';
import 'package:my_books/domain/usecases/firestore/check_book_like_usecase.dart';
import 'package:my_books/domain/usecases/firestore/delete_book_from_favourite_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_book_by_id_usecase.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookByIDUseCase getBookByIDUseCase;
  final AddBookToFavouriteUseCase addBookToFavouriteUseCase;
  final DeleteBookFromFavouriteUseCase deleteBookFromFavouriteUseCase;
  final CheckBookLikeUseCase checkBookLikeUseCase;

  BookDetailBloc({
    required this.getBookByIDUseCase,
    required this.addBookToFavouriteUseCase,
    required this.deleteBookFromFavouriteUseCase,
    required this.checkBookLikeUseCase,
  }) : super(InitialState()) {
    on<InitialEvent>((event, emit) async {
      try {
        var book = await getBookByIDUseCase.getBookByID(event.id);
        var likeStream = checkBookLikeUseCase.checkBookLike(book?.id ?? '');
        emit(ShowingBookState(book: book, likeStream: likeStream));
      } catch (e) {
        emit(ErrorBookState(e.toString()));
      }
    });

    on<LikedEvent>((event, emit) async {
      try {
        await addBookToFavouriteUseCase.addBookToFavourite(event.bookID);
      } catch (e) {
        emit(ErrorBookState(e.toString()));
      }
    });

    on<UnlikedEvent>((event, emit) async {
      try {
        await deleteBookFromFavouriteUseCase
            .deleteBookFromFavourite(event.bookID);
      } catch (e) {
        emit(ErrorBookState(e.toString()));
      }
    });
  }
}
