import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          return Text(AppLocalizations.of(context)?.something_went_wrong ?? '');
        } else {
          var books = snapshot.requireData;

          if (books.isNotEmpty) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: books.length + 1,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index == books.length) {
                    return const SizedBox();
                  }

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
                });
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
