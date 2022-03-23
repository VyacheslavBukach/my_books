import 'package:get_it/get_it.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/data/repositories/firestore_book_repository_impl.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/auth/register_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_books_usecase.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton(FirebaseAuthRepositoryImpl());
  getIt.registerSingleton(FirestoreBookRepositoryImpl());
  getIt.registerSingleton(
      LoginUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(
      RegisterUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(
      LogoutUseCase(authRepo: getIt<FirebaseAuthRepositoryImpl>()));
  getIt.registerSingleton(
      GetBooksUseCase(bookRepository: getIt<FirestoreBookRepositoryImpl>()));
}
