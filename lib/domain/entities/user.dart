import 'package:my_books/domain/entities/book.dart';

class User {
  String id;
  List<Book> favourites;

  User({required this.id, required this.favourites});
}
