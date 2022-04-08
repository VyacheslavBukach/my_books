import '../../entities/book.dart';
import '../../repositories/book_repository.dart';

class GetFilteredBooks {
  final BookRepository bookRepository;

  GetFilteredBooks({required this.bookRepository});

  Stream<List<Book>> getFilteredBooks(List<String> genres) {
    return bookRepository.getFilteredBooks(genres);
  }
}
