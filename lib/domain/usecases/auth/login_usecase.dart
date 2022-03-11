import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';

class LoginUseCase {
  // TODO add repo in constructor
  final AuthRepository _authRepo = FirebaseAuthRepositoryImpl();

  Future call(String email, String password) async {
    return await _authRepo.login(email, password);
  }
}
