import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';

class LoginUseCase {
  LoginUseCase(this._authRepo);

  final FirebaseAuthRepositoryImpl _authRepo;

  Future call() async {
    return await _authRepo.login();
  }
}
