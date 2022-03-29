import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetBookByIDUseCase {
  final BookRepository bookRepository;

  GetBookByIDUseCase({required this.bookRepository});

  Future<Book> getBookByID(String id) async {
    return await bookRepository.getBook(id);
  }
}
