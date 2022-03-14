import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc({required this.authUseCase}) : super(UnAuthenticated()) {
    on<SignInRequested>(
      (event, emit) async {
        emit(Loading());
        try {
          await authUseCase.login(event.email, event.password);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      },
    );
    on<SignUpRequested>(
      (event, emit) async {
        emit(Loading());
        try {
          await authUseCase.register(event.email, event.password);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      },
    );
    on<SignOutRequested>(
      (event, emit) async {
        emit(Loading());
        await authUseCase.logout();
        emit(UnAuthenticated());
      },
    );
  }
}
