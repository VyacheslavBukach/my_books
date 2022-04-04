import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetFavouriteBooksStreamUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  GetFavouriteBooksStreamUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Stream<QuerySnapshot> getFavouriteBooks() {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.getFavouriteBooksStream(userID: userID);
  }
}
