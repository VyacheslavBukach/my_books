import '../../entities/book.dart';
import '../../repositories/book_repository.dart';

class GetFilteredBooksUseCase {
  final BookRepository bookRepository;

  GetFilteredBooksUseCase({required this.bookRepository});

  Stream<List<Book>> getFilteredBooks(List<String> genres) {
    return bookRepository.getFilteredBooks(genres);
  }
}
