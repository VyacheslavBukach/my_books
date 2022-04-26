import 'package:my_books/domain/repositories/auth_repository.dart';

class GetCurrentUserEmailUseCase {
  final AuthRepository authRepository;

  GetCurrentUserEmailUseCase({
    required this.authRepository,
  });

  String getCurrentUserEmail() => authRepository.currentUser?.email ?? '';
}
