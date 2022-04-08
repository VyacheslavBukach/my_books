import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../domain/entities/book.dart';
import 'vertical_book_list_item.dart';

class VerticalBookList extends StatelessWidget {
  final Stream<List<Book>> books;

  const VerticalBookList({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: books,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var books = snapshot.requireData;

        return ListView.separated(
          itemCount: books.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => VerticalBookListItem(
            book: books[index],
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(
                BookClickedEvent(bookID: books[index].id),
              );
            },
          ),
        );
      },
    );
  }
}
