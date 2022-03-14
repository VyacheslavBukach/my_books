import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';

class LoginUseCase {
  // TODO add repo in constructor
  LoginUseCase({required this.authRepo});

  final AuthRepository authRepo;

  Future call(String email, String password) async {
    return await authRepo.signIn(email, password);
  }
}
