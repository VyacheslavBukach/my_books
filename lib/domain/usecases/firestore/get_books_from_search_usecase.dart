import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetBooksFromSearchUseCase {
  final BookRepository bookRepository;

  GetBooksFromSearchUseCase({
    required this.bookRepository,
  });

  Stream<List<Book>> getBooksFromSearch(String query) {
    return bookRepository.getBooksByQuery(query);
  }
}
