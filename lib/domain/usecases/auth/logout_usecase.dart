import '../../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepo;

  LogoutUseCase({required this.authRepo});

  Future<void> logout() async {
    return await authRepo.signOut();
  }
}
