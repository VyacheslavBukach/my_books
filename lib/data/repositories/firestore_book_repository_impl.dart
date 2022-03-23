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
  Future<Book> getBook(int id) async {
    // TODO: implement getBook
    throw UnimplementedError();
  }
}
