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
    'id': 'bookID',
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
    await fakeFirestore.collection(_kBooks).doc('bookID').set(book);

    final actualBook = await bookRepository.getBookByID('bookID');

    expect(actualBook?.id ?? '', 'bookID');
  });

  test('check book like test', () async {
    await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .doc('bookID')
        .set({});

    final bookExist = await bookRepository
        .checkBookLike(bookID: 'bookID', userID: 'userID')
        .first;

    expect(bookExist, true);
  });

  test('get favourite books test', () async* {
    await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .doc('bookID')
        .set({});

    final books =
        await bookRepository.getFavouriteBooks(userID: 'userID').first;

    expect(books.first.id, 'bookID');
  });

  test('get all books test', () async {
    await fakeFirestore.collection(_kBooks).add(book);

    final books = await bookRepository.getAllBooks().first;

    expect(books.first.id, 'bookID');
  });

  test('get popular books test', () async {
    List<Book> expectedList = List.generate(
      10,
      (index) => Book(
        id: index.toString(),
        title: '',
        author: '',
        // createdAt: '2022-05-26 17:44:46.782595',
        createdAt: DateTime.parse('2022-05-26 17:44:46.782595'),
        description: '',
        genre: List.empty(),
        popular: index.toDouble(),
        posterUrl: '',
      ),
    );
    // print(expectedList);

    List<Book> storeBooks = [
      ...expectedList,
      Book(
        id: '10',
        title: '',
        author: '',
        // createdAt: '2022-05-26 17:44:46.782595',
        createdAt: DateTime.parse('2022-05-26 17:44:46.782595'),
        description: '',
        genre: List.empty(),
        popular: 0.0,
        posterUrl: '',
      ),
    ];
    // print(storeBooks);

    List<Map<String, dynamic>> books = [];
    for (var book in storeBooks) {
      books.add(book.toJson());
    }
    print(books);
    for (int i = 0; i < 11; i++) {
      await fakeFirestore.collection(_kBooks).doc(i.toString()).set(books[i]);
    }

    final popularBooks = await bookRepository.getPopularBooks();
    // print(popularBooks);

    expect(popularBooks, equals(expectedList));
  });

  test('get new books test', () {});

  test('get filtered books test', () {});

  test('get books by query test', () {});

  test('add book to favourite test', () async {
    await bookRepository.addBookToFavourite(userID: 'userID', bookID: 'bookID');

    final idList = await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList())
        .first;

    expect(idList.first, 'bookID');
  });

  test('delete book from favourite test', () async {
    await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .doc('bookID')
        .set({});

    await bookRepository.deleteBookFromFavourite(
        userID: 'userID', bookID: 'bookID');

    List<String> idList = await fakeFirestore
        .collection(_kUsers)
        .doc('userID')
        .collection(_kFavourites)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList())
        .first;

    expect(idList, equals(List.empty()));
  });
}
