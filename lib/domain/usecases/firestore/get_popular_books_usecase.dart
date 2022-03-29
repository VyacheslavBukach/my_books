import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetPopularBooksUseCase {
  final BookRepository bookRepository;

  GetPopularBooksUseCase({required this.bookRepository});

  Future<List<Book>> getPopularBooks() async {
    return await bookRepository.getPopularBooks();
  }
}
