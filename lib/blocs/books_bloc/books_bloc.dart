import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/check_book_like_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final CheckBookLikeUseCase checkBookLikeUseCase;

  BooksBloc({
    required this.checkBookLikeUseCase,
  }) : super(ShowingBooksState()) {
    on<InitialBooksEvent>((event, emit) async {});
  }
}
