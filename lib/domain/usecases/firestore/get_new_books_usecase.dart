import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetNewBooksUseCase {
  final BookRepository bookRepository;

  GetNewBooksUseCase({required this.bookRepository});

  Future<QuerySnapshot<Book>> getNewBooks() async {
    return await bookRepository.getNewBooks();
  }
}
