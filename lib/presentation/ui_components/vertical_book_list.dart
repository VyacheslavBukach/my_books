import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/book.dart';
import '../screens/book_detail_screen.dart';
import 'vertical_book_list_item.dart';

class VerticalBookList extends StatelessWidget {
  final Stream<List<Book>> bookList;

  const VerticalBookList({
    Key? key,
    required this.bookList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: bookList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)?.something_went_wrong ?? '');
        } else {
          var books = snapshot.requireData;

          if (books.isNotEmpty) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 270,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return VerticalBookListItem(
                  book: books[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailScreen(bookID: books[index].id),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)?.no_favourites ?? ''),
            );
          }
        }
      },
    );
  }
}
