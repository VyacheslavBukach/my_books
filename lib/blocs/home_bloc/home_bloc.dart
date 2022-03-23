import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/usecases/firestore/get_books_usecase.dart';

import '../../domain/usecases/auth/logout_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LogoutUseCase logoutUseCase;
  final GetBooksUseCase getBooksUseCase;

  HomeBloc({
    required this.logoutUseCase,
    required this.getBooksUseCase,
  }) : super(AuthenticatedState()) {
    on<SignOutEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await logoutUseCase.logout();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(AuthenticatedState());
      }
    });
    on<LoadBooksEvent>((event, emit) async {
      emit(LoadingState());
      try {
        var list = await getBooksUseCase.getBooks();
        emit(AuthenticatedState(books: list));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
