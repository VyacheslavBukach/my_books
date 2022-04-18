import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_books_from_search_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_filtered_books_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetAllBooksUseCase getAllBooksUseCase;
  final GetFilteredBooksUseCase getFilteredBooksUseCase;

  StoreBloc({
    required this.getAllBooksUseCase,
    required this.getFilteredBooksUseCase,
  }) : super(InitialState()) {
    on<FilterByDefaultEvent>((event, emit) async {
      var stream = getAllBooksUseCase.getAllBooks();
      emit(DefaultStoreState(bookStream: stream));
    });

    on<FilterByGenresEvent>((event, emit) async {
      var stream = getFilteredBooksUseCase.getFilteredBooks(event.genres);
      emit(FilteredStoreState(bookStream: stream));
    });
  }
}
