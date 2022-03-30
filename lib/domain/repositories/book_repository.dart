import 'package:my_books/domain/entities/book.dart';

abstract class BookRepository {
  Future<Book?> getBook(String id);

  Future<List<Book>> getAllBooks();

  Future<void> addBookToFavourite({
    required String userID,
    required String bookID,
  });

  Future<void> deleteBookFromFavourite({
    required String userID,
    required String bookID,
  });

  Future<List<Book>> getPopularBooks();

  Future<List<Book>> getNewBooks();
}
