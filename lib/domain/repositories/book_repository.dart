import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';

abstract class BookRepository {
  FirebaseFirestore get firestore;

  Future<Book?> getBookByID(String id);

  Stream<DocumentSnapshot> getFavouriteBookStream({
    required String userID,
    required String bookID,
  });

  Stream<QuerySnapshot> getFavouriteBooksStream({required String userID});

  Stream<List<Book>> getAllBooks();

  Future<List<Book>> getPopularBooks();

  Future<List<Book>> getNewBooks();

  Future<void> addBookToFavourite({
    required String userID,
    required String bookID,
  });

  Future<void> deleteBookFromFavourite({
    required String userID,
    required String bookID,
  });
}
