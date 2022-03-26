import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';

abstract class BookRepository {
  Future<Book> getBook(int id);

  Future<List<Book>> getAllBooks();

  Future<void> addBookToFavourite(int id);

  Future<void> deleteBookFromFavourite(int id);

  Future<QuerySnapshot<Book>> getPopularBooks();
}
