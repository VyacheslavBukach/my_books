import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';
import 'package:my_books/domain/repositories/book_repository.dart';
import 'package:my_books/domain/usecases/firestore/add_book_to_favourite_usecase.dart';

import 'add_book_to_favourite_usecase_test.mocks.dart';

class BookRepositoryMock extends Mock implements BookRepository {}

@GenerateMocks([BookRepository, AuthRepository, User])
void main() {
  late AddBookToFavouriteUseCase addBookToFavouriteUseCase;
  late BookRepository bookRepository;
  late AuthRepository authRepository;
  late User user;

  setUp(() {
    bookRepository = BookRepositoryMock();
    authRepository = MockAuthRepository();
    user = MockUser();

    addBookToFavouriteUseCase = AddBookToFavouriteUseCase(
      authRepository: authRepository,
      bookRepository: bookRepository,
    );
  });

  test('add book to favourite test', () async {
    when(authRepository.currentUser).thenReturn(user);
    when(user.uid).thenReturn('uid');

    when(bookRepository.addBookToFavourite(userID: 'uid', bookID: 'bookId'))
        .thenAnswer((_) async => Future.value());

    await addBookToFavouriteUseCase.addBookToFavourite('bookId');

    verify(() async =>
            bookRepository.addBookToFavourite(userID: 'uid', bookID: 'bookId'))
        .called(1);
  });
}
