import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/check_book_like_usecase.dart';

part 'favourite_books_event.dart';
part 'favourite_books_state.dart';

class FavouriteBooksBloc
    extends Bloc<FavouriteBooksEvent, FavouriteBooksState> {
  final CheckBookLikeUseCase checkBookLikeUseCase;

  FavouriteBooksBloc({
    required this.checkBookLikeUseCase,
  }) : super(ShowingBooksState()) {
    on<InitialBooksEvent>((event, emit) async {});
  }
}
