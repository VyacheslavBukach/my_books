import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_new_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LogoutUseCase logoutUseCase;
  final GetNewBooksUseCase getNewBooksUseCase;
  final GetPopularBooksUseCase getPopularBooksUseCase;

  HomeBloc({
    required this.logoutUseCase,
    required this.getPopularBooksUseCase,
    required this.getNewBooksUseCase,
  }) : super(InitialState()) {
    on<InitialEvent>((event, emit) async {
      try {
        var popular = getPopularBooksUseCase.getPopularBooks();
        var releases = getNewBooksUseCase.getNewBooks();
        emit(
          AuthenticatedState(
            popularBooks: popular,
            releaseBooks: releases,
          ),
        );
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      try {
        await logoutUseCase.logout();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(UnauthenticatedState());
      }
    });
  }
}
