import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

const _kBooks = 'books';
const kUsers = 'users';
const _kFavourites = 'favourites';

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
        .collection(kUsers)
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
        .collection(kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .doc(bookID)
        .delete();
  }

  @override
  Future<List<Book>> getAllBooks() async {
    // TODO: implement getAllBooks
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot> getFavouriteBookStream({
    required String userID,
    required String bookID,
  }) {
    return _firestore
        .collection(kUsers)
        .doc(userID)
        .collection(_kFavourites)
        .doc(bookID)
        .snapshots();
  }

  // @override
  // Stream<DocumentSnapshot> getFavouriteBooks(String userID) {
  //   List<Book> books = [];
  //
  //   var s = getFavouriteBooksStream(userID);
  //
  //   _firestore.collection(kUsers).doc(userID).get().then((snapshot) async {
  //     var bookID = snapshot.data()?['favourites'];
  //     for (var element in bookID) {
  //       var book = await getBookByID(element);
  //       books.add(book!); // TODO
  //     }
  //   });
  //
  //   return books;
  // }

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
}
