import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetFilteredBooksUseCase {
  final BookRepository bookRepository;

  GetFilteredBooksUseCase({required this.bookRepository});

  Stream<List<Book>> getFilteredBooks(List<String> genres) {
    return bookRepository.getFilteredBooks(genres);
  }
}
