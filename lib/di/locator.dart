import 'package:get_it/get_it.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/data/repositories/firestore_book_repository_impl.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/auth/register_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_book_by_id_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';

import '../domain/usecases/firestore/get_new_books_usecase.dart';

final getIt = GetIt.instance;

void initGetIt() {
  // Firebase
  getIt.registerSingleton(FirebaseAuthRepositoryImpl());
  getIt.registerSingleton(FirestoreBookRepositoryImpl());
  // Use cases
  getIt.registerSingleton(
      LoginUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(
      RegisterUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(
      LogoutUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(GetPopularBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>()));
  getIt.registerSingleton(
      GetNewBooksUseCase(bookRepository: getIt<FirestoreBookRepositoryImpl>()));
  getIt.registerSingleton(
      GetBookByIDUseCase(bookRepository: getIt<FirestoreBookRepositoryImpl>()));
}
