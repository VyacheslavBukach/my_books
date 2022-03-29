import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class FirestoreBookRepositoryImpl implements BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addBookToFavourite(int id) async {
    // TODO: implement addBookToFavourite
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBookFromFavourite(int id) async {
    // TODO: implement deleteBookFromFavourite
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getAllBooks() async {
    // TODO: implement getAllBooks
    throw UnimplementedError();
  }

  @override
  Future<Book?> getBook(String id) async {
    return await _firestore
        .collection('books')
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
        .collection('books')
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
        .collection('books')
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
