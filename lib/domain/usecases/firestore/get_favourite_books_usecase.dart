import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetFavouriteBooksUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  GetFavouriteBooksUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Stream<List<Book>> getFavouriteBooks() {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.getFavouriteBooks(userID: userID);
  }
}
