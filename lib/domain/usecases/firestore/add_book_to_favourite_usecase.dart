import 'package:my_books/domain/repositories/auth_repository.dart';

import '../../repositories/book_repository.dart';

class AddBookToFavouriteUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  AddBookToFavouriteUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Future<void> addBookToFavourite(String bookID) async {
    return await bookRepository.addBookToFavourite(
      userID: authRepository.currentUser?.uid ?? '',
      bookID: bookID,
    );
  }
}
