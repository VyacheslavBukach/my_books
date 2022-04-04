import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/domain/repositories/book_repository.dart';

class GetBooksByIDUseCase {
  final BookRepository bookRepository;

  GetBooksByIDUseCase({required this.bookRepository});

  Future<List<Book>> getBooksByID(List<String> list) async {
    List<Book> books = [];

    for (var element in list) {
      var book = await bookRepository.getBookByID(element);
      if (book != null) {
        books.add(book);
      }
    }

    return books;
  }
}
