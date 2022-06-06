import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/data/repositories/firestore_book_repository_impl.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/auth/register_usecase.dart';
import 'package:my_books/domain/usecases/firestore/add_book_to_favourite_usecase.dart';
import 'package:my_books/domain/usecases/firestore/check_book_like_usecase.dart';
import 'package:my_books/domain/usecases/firestore/delete_book_from_favourite_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_book_by_id_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_books_from_search_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_favourite_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_filtered_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_new_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';

final getIt = GetIt.instance;

void initGetIt() {
  // Firebase
  getIt.registerSingleton(
    FirebaseAuthRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
  );
  getIt.registerSingleton(
    FirestoreBookRepositoryImpl(firestore: FirebaseFirestore.instance),
  );
  // Use cases
  getIt.registerSingleton(
    LoginUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    RegisterUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    LogoutUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetPopularBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetNewBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetBookByIDUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    AddBookToFavouriteUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    DeleteBookFromFavouriteUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    CheckBookLikeUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetFavouriteBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetAllBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetFilteredBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    GetBooksFromSearchUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
}
