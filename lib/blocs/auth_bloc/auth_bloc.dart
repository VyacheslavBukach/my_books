import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc({required this.authUseCase}) : super(UnAuthenticatedState()) {
    on<SignInRequested>(
      (event, emit) async {
        emit(LoadingState());
        try {
          await authUseCase.login(event.email, event.password);
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(e.toString()));
          emit(UnAuthenticatedState());
        }
      },
    );
    on<SignOutRequested>(
      (event, emit) async {
        emit(LoadingState());
        await authUseCase.logout();
        emit(UnAuthenticatedState());
      },
    );
  }
}
