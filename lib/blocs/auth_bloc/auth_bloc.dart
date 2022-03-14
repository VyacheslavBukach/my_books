import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final LoginUseCase _loginUseCase =
      LoginUseCase(authRepo: authRepository);

  AuthBloc({required this.authRepository}) : super(UnAuthenticatedState()) {
    on<SignInRequested>(
      (event, emit) async {
        emit(LoadingState());
        try {
          _loginUseCase.call(event.email, event.password);
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(e.toString()));
          emit(UnAuthenticatedState());
        }
      },
    );
  }
}
