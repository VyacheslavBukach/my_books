import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository bookRepository;

  GetBooksUseCase({required this.bookRepository});

  Future<List<Book>> getBooks() async {
    return await bookRepository.getAllBooks();
  }
}
