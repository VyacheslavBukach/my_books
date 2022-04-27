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
        child: Column(
          children: [
            Ink.image(
              height: 200,
              image: NetworkImage(book.posterUrl),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoSlab(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoSlab(
                      color: Theme.of(context).colorScheme.onSurface,
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      Text(
                        book.popular.toString(),
                        style: GoogleFonts.robotoSlab(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
