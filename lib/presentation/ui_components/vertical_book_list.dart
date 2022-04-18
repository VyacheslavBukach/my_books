import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';
import '../screens/book_detail_screen.dart';
import 'vertical_book_list_item.dart';

class VerticalBookList extends StatelessWidget {
  final Stream<List<Book>> bookStream;

  const VerticalBookList({
    Key? key,
    required this.bookStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: bookStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Something went wrong ${snapshot.error}");
        } else {
          var books = snapshot.requireData;

          if (books.isNotEmpty) {
            return ListView.separated(
              itemCount: books.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => VerticalBookListItem(
                book: books[index],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          BookDetailScreen(bookID: books[index].id),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('No favourites'),
            );
          }
        }
      },
    );
  }
}
