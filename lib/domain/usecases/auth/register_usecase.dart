import 'package:my_books/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepo;

  RegisterUseCase({required this.authRepo});

  Future<void> register(String email, String password) async {
    return await authRepo.signUp(email, password);
  }
}
