import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/repositories/firestore_book_repository_impl.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/book_repository.dart';

class GetFavouriteBookStreamUseCase {
  final BookRepository bookRepository;
  final AuthRepository authRepository;

  GetFavouriteBookStreamUseCase({
    required this.bookRepository,
    required this.authRepository,
  });

  Stream<DocumentSnapshot> getFavouriteBookStream(String bookID) {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.getFavouriteBookStream(
        userID: userID, bookID: bookID);
  }
}
