import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}
