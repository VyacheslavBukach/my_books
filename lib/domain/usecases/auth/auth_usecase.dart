import 'package:my_books/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepo;

  AuthUseCase({required this.authRepo});

  Future<void> login(String email, String password) async {
    return await authRepo.signIn(email, password);
  }

  Future<void> register(String email, String password) async {
    return await authRepo.signUp(email, password);
  }

  Future<void> logout() async {
    return await authRepo.signOut();
  }
}
