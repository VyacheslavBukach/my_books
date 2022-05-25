import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/data/repositories/firestore_book_repository_impl.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

const _kBooks = 'books';
const _kUsers = 'users';
const _kFavourites = 'favourites';
const _kPopular = 'popular';
const _kCreatedAt = 'createdAt';
const _kGenre = 'genre';
const _kBookSearch = 'bookSearch';

void main() {
  late FirebaseFirestore fakeFirestore;
  late BookRepository bookRepository;

  final book = {
    'id': 'bookId',
    'title': 'title',
    'author': 'author',
    'popular': 1,
    'createdAt': DateTime.now(),
    'genre': List.empty(),
    'description': 'description',
    'posterUrl': 'posterUrl',
  };

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    bookRepository = FirestoreBookRepositoryImpl(firestore: fakeFirestore);
  });

  test('get book by ID test', () async {
    await fakeFirestore.collection(_kBooks).doc('bookId').set(book);

    final actualBook = await bookRepository.getBookByID('bookId');

    expect(actualBook!.id, 'bookId');
  });

  test('check book like test', () {});

  test('get favourite books test', () async {
    await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .doc('bookID')
        .set({});

    List<Book> list =
        await bookRepository.getFavouriteBooks(userID: 'userID').first;

    expect(list.first.id, 'bookID');
  });

  test('get all books test', () {});

  test('get popular books test', () {});

  test('get new books test', () {});

  test('get filtered books test', () {});

  test('get books by query test', () {});

  test('add book to favourite test', () async {
    await bookRepository.addBookToFavourite(userID: 'userID', bookID: 'bookID');

    List<String> idList = await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList())
        .first;

    expect(idList.first, 'bookID');
  });

  test('delete book from favourite test', () {});
}
