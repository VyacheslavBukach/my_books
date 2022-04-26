import 'package:my_books/domain/repositories/book_repository.dart';

import '../../entities/book.dart';

class GetBooksFromSearchUseCase {
  final BookRepository bookRepository;

  GetBooksFromSearchUseCase({
    required this.bookRepository,
  });

  Stream<List<Book>> getBooksFromSearch(String query) {
    return bookRepository.getBooksByQuery(query);
  }
}
