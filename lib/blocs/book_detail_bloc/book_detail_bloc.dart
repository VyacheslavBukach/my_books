import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_book_by_id_usecase.dart';

import '../../domain/entities/book.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookByIDUseCase getBookByIDUseCase;

  BookDetailBloc({
    required this.getBookByIDUseCase,
  }) : super(LoadingBookState()) {
    on<OpenBookDetailEvent>((event, emit) async {
      try {
        var book = await getBookByIDUseCase.getBookByID(event.id);
        emit(SuccessBookState(book: book));
      } catch (e) {
        emit(ErrorBookState(e.toString()));
      }
    });
  }
}
