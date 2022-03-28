import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/auth/logout_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LogoutUseCase logoutUseCase;

  HomeBloc({
    required this.logoutUseCase,
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

    on<BookClickedEvent>((event, emit) async {
      try {
        String id = event.bookID;
        emit(ShowingBookDetailState(id));
        // TODO delete
        emit(AuthenticatedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(AuthenticatedState());
      }
    });
  }
}
