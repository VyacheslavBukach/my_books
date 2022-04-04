import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetFavouriteBookIDsUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  GetFavouriteBookIDsUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Stream<QuerySnapshot> getFavouriteBookIDs() {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.getFavouriteBookIDs(userID: userID);
  }
}
