import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      color: Theme.of(context).colorScheme.surface,
      elevation: 1,
      shadowColor: Theme.of(context).colorScheme.shadow,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        onTap: onTap,
        child: SizedBox(
          height: 165,
          child: Row(
            children: [
              Ink.image(
                width: 120,
                image: NetworkImage(book.posterUrl),
                fit: BoxFit.fitWidth,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.robotoSlab(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.robotoSlab(
                          color: Theme.of(context).colorScheme.onSurface,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(book.popular.toString()),
                        ],
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
