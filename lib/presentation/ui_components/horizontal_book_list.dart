import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/presentation/screens/book_detail_screen.dart';
import 'package:my_books/presentation/ui_components/horizontal_book_list_item.dart';

class HorizontalBookList extends StatelessWidget {
  final double bookWidth;
  final Future<List<Book>> bookList;

  const HorizontalBookList({
    Key? key,
    required this.bookWidth,
    required this.bookList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: bookList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          // case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Text(
                  AppLocalizations.of(context)?.something_went_wrong ?? '');
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;

              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => HorizontalBookListItem(
                  onClick: () {
                    String id = data[index].id;
                    _bookClickedEvent(context, id);
                  },
                  width: bookWidth,
                  posterUrl: data[index].posterUrl,
                ),
              );
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
        }
      },
    );
  }

  void _bookClickedEvent(context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(bookID: id),
      ),
    );
  }
}
