import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_book_stream_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetFavouriteBookStreamUseCase getFavouriteBookStreamUseCase;

  BooksBloc({
    required this.getFavouriteBookStreamUseCase,
  }) : super(ShowingBooksState()) {
    on<InitialBooksEvent>((event, emit) async {});
  }
}
