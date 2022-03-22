import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepo;

  LoginUseCase({required this.authRepo});

  Future<void> login(String email, String password) async {
    return await authRepo.signIn(email, password);
  }
}
