import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../domain/entities/book.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  final double bookWidth;
  final Future<QuerySnapshot<Book>> usecase;

  const BookList({
    Key? key,
    required this.bookWidth,
    required this.usecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Book>>(
      future: usecase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.requireData;

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: data.size,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BookCard(
              onClick: () {
                String id = data.docs[index].data().id;
                _bookClickedEvent(context, id);
              },
              width: bookWidth,
              posterUrl: data.docs[index].data().posterUrl,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _bookClickedEvent(context, String id) {
    BlocProvider.of<HomeBloc>(context).add(BookClickedEvent(bookID: id));
  }
}
