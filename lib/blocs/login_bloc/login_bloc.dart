import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(UnauthenticatedState()) {
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
  }
}
