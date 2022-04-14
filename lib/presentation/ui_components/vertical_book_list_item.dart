import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';

class VerticalBookListItem extends StatelessWidget {
  final Book book;
  final Function() onTap;

  const VerticalBookListItem({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.blue.shade100.withOpacity(0.5),
        onTap: onTap,
        child: SizedBox(
          height: 151,
          child: Row(
            children: [
              Ink.image(
                width: 120,
                image: NetworkImage(book.posterUrl),
                fit: BoxFit.fitWidth,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Wrap(
                        spacing: 4,
                        children: [
                          for (final genre in book.genre)
                            Chip(label: Text(genre)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
