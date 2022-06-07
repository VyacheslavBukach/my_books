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
import 'package:my_books/presentation/blocs/book_detail_bloc/book_detail_bloc.dart';
import 'package:my_books/presentation/blocs/favourite_books_bloc/favourite_books_bloc.dart';
import 'package:my_books/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:my_books/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:my_books/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:my_books/presentation/blocs/store_bloc/store_bloc.dart';

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
  getIt.registerFactory(
    () => LoginUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => RegisterUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => LogoutUseCase(
      authRepo: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetPopularBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetNewBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetBookByIDUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => AddBookToFavouriteUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => DeleteBookFromFavouriteUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => CheckBookLikeUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetFavouriteBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
      authRepository: getIt<FirebaseAuthRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetAllBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetFilteredBooksUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => GetBooksFromSearchUseCase(
      bookRepository: getIt<FirestoreBookRepositoryImpl>(),
    ),
  );
  // Blocs
  getIt.registerFactory(
    () => LoginBloc(loginUseCase: getIt<LoginUseCase>()),
  );
  getIt.registerFactory(
    () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
  );
  getIt.registerFactory(
    () => HomeBloc(
      getNewBooksUseCase: getIt<GetNewBooksUseCase>(),
      getPopularBooksUseCase: getIt<GetPopularBooksUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => BookDetailBloc(
      addBookToFavouriteUseCase: getIt<AddBookToFavouriteUseCase>(),
      checkBookLikeUseCase: getIt<CheckBookLikeUseCase>(),
      deleteBookFromFavouriteUseCase: getIt<DeleteBookFromFavouriteUseCase>(),
      getBookByIDUseCase: getIt<GetBookByIDUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => FavouriteBooksBloc(
      getFavouriteBooksUseCase: getIt<GetFavouriteBooksUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => SearchBloc(
      getBooksFromSearchUseCase: getIt<GetBooksFromSearchUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => StoreBloc(
      getAllBooksUseCase: getIt<GetAllBooksUseCase>(),
      getFilteredBooksUseCase: getIt<GetFilteredBooksUseCase>(),
    ),
  );
}
