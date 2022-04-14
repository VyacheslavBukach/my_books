import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetAllBooksUseCase {
  final BookRepository bookRepository;

  GetAllBooksUseCase({required this.bookRepository});

  Stream<List<Book>> getAllBooks() {
    return bookRepository.getAllBooks();
  }
}
