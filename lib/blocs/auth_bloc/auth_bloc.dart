import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/auth/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(UnauthenticatedState()) {
    on<SignInEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          await loginUseCase.login(event.email, event.password);
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(e.toString()));
          emit(UnauthenticatedState());
        }
      },
    );
    on<SignUpEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          await registerUseCase.register(event.email, event.password);
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(e.toString()));
          emit(UnauthenticatedState());
        }
      },
    );
    on<SignOutEvent>(
      (event, emit) async {
        emit(LoadingState());
        await logoutUseCase.logout();
        emit(UnauthenticatedState());
      },
    );
  }
}
