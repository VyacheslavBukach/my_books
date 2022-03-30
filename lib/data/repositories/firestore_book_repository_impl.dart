import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

const _kBooks = 'books';
const _kUsers = 'users';
const _kFavourites = 'favourites';

class FirestoreBookRepositoryImpl implements BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addBookToFavourite({
    required String userID,
    required String bookID,
  }) async {
    await _firestore
        .collection(_kUsers)
        .doc(userID)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        _addBook(userID, bookID);
      } else {
        _createEmptyFavouriteList(userID);
        _addBook(userID, bookID);
      }
    });
  }

  @override
  Future<void> deleteBookFromFavourite({
    required String userID,
    required String bookID,
  }) async {
    await _firestore
        .collection(_kUsers)
        .doc(userID)
        .get()
        .then((documentSnapshot) {
      _deleteBook(userID, bookID);
    });
  }

  @override
  Future<List<Book>> getAllBooks() async {
    // TODO: implement getAllBooks
    throw UnimplementedError();
  }

  @override
  Future<Book?> getBook(String id) async {
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
        .orderBy('popular', descending: true)
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
        .orderBy('createdAt', descending: true)
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

  Future<void> _addBook(String userID, String bookID) async {
    CollectionReference users = _firestore.collection(_kUsers);
    await users.doc(userID).update({
      _kFavourites: FieldValue.arrayUnion([bookID])
    });
  }

  Future<void> _deleteBook(String userID, String bookID) async {
    CollectionReference users = _firestore.collection(_kUsers);
    await users.doc(userID).update({
      _kFavourites: FieldValue.arrayRemove([bookID])
    });
  }

  Future<void> _createEmptyFavouriteList(String userID) async {
    CollectionReference users = _firestore.collection(_kUsers);
    await users.doc(userID).set({_kFavourites: []});
  }
}
