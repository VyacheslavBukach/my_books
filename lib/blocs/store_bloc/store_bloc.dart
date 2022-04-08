import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_filtered_books_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetAllBooksUseCase getAllBooksUseCase;
  final GetFilteredBooks getFilteredBooks;

  StoreBloc({
    required this.getAllBooksUseCase,
    required this.getFilteredBooks,
  }) : super(DefaultStoreState()) {
    on<FilterByDefaultEvent>((event, emit) {
      emit(DefaultStoreState());
    });

    on<FilterByGenresEvent>((event, emit) {
      emit(FilteredStoreState(genres: event.genres));
    });
  }
}
