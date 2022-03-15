import 'package:my_books/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepo;

  AuthUseCase({required this.authRepo});

  Future login(String email, String password) async {
    return await authRepo.signIn(email, password);
  }

  Future register(String email, String password) async {
    return await authRepo.signUp(email, password);
  }

  Future logout() async {
    return await authRepo.signOut();
  }
}
