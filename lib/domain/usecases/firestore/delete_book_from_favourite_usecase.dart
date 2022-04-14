import '../../repositories/auth_repository.dart';
import '../../repositories/book_repository.dart';

class DeleteBookFromFavouriteUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  DeleteBookFromFavouriteUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Future<void> deleteBookFromFavourite(String bookID) async {
    return await bookRepository.deleteBookFromFavourite(
      userID: authRepository.currentUser?.uid ?? '',
      bookID: bookID,
    );
  }
}
