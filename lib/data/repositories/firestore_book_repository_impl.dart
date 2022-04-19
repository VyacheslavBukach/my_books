import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

const _kBooks = 'books';
const _kUsers = 'users';
const _kFavourites = 'favourites';
const _kPopular = 'popular';
const _kCreatedAt = 'createdAt';
const _kGenre = 'genre';
const _kBookSearch = 'bookSearch';

class FirestoreBookRepositoryImpl implements BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  FirebaseFirestore get firestore => _firestore;

  @override
  Future<void> addBookToFavourite({
    required String userID,
    required String bookID,
  }) async {
    await _firestore
        .collection(_kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .doc(bookID)
        .set({});
  }

  @override
  Future<void> deleteBookFromFavourite({
    required String userID,
    required String bookID,
  }) async {
    await _firestore
        .collection(_kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .doc(bookID)
        .delete();
  }

  @override
  Stream<List<Book>> getAllBooks() {
    var stream = _firestore
        .collection(_kBooks)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .snapshots();

    return stream
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Stream<bool> checkBookLike({
    required String userID,
    required String bookID,
  }) {
    var stream = _firestore
        .collection(_kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .doc(bookID)
        .snapshots();

    return stream.map((snapshot) => snapshot.exists);
  }

  @override
  Stream<List<Book>> getFavouriteBooks({required String userID}) async* {
    List<Book> books = [];

    Stream<List<String>> streamIdList = _firestore
        .collection(_kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());

    await for (final idList in streamIdList) {
      books = [];
      for (var id in idList) {
        var book = await getBookByID(id);
        if (book != null) {
          books.add(book);
        }
      }
      yield books;
    }
  }

  @override
  Future<Book?> getBookByID(String id) async {
    return await _firestore
        .collection(_kBooks)
        .doc(id)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .get()
        .then((value) => value.data());
  }

  @override
  Future<List<Book>> getPopularBooks() async {
    List<Book> books = [];

    await _firestore
        .collection(_kBooks)
        .orderBy(_kPopular, descending: true)
        .limit(10)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .get()
        .then((snapshot) {
      for (var element in snapshot.docs) {
        books.add(element.data());
      }
    });

    return books;
  }

  @override
  Future<List<Book>> getNewBooks() async {
    List<Book> books = [];

    await _firestore
        .collection(_kBooks)
        .orderBy(_kCreatedAt, descending: true)
        .limit(10)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .get()
        .then((snapshot) {
      for (var element in snapshot.docs) {
        books.add(element.data());
      }
    });

    return books;
  }

  @override
  Stream<List<Book>> getFilteredBooks(List<String> genres) {
    var stream = _firestore
        .collection(_kBooks)
        .where(_kGenre, arrayContainsAny: genres)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .snapshots();

    return stream
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Stream<List<Book>> getBooksByQuery(String query) {
    var stream = _firestore
        .collection(_kBooks)
        .where(_kBookSearch, arrayContains: query)
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        )
        .snapshots();

    return stream
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
