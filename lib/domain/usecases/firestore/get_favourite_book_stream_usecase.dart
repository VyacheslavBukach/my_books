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

  // TODO
  Stream<DocumentSnapshot> getFavouriteBookStream() {
    String userID = authRepository.currentUser?.uid ?? '';
    return bookRepository.firestore.collection(kUsers).doc(userID).snapshots();
  }
}
