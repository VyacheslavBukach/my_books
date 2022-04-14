import '../../repositories/auth_repository.dart';
import '../../repositories/book_repository.dart';

class CheckBookLikeUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  CheckBookLikeUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Stream<bool> checkBookLike(String bookID) {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.checkBookLike(userID: userID, bookID: bookID);
  }
}
