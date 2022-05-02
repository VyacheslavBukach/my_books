import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/book.dart';
import '../screens/book_detail_screen.dart';

class SearchResultItem extends StatelessWidget {
  final Book book;

  const SearchResultItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: CachedNetworkImage(
        imageUrl: book.posterUrl,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      title: Text(
        book.title,
        style: GoogleFonts.robotoSlab(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        book.author,
        style: GoogleFonts.robotoSlab(),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookDetailScreen(
            bookID: book.id,
          ),
        ),
      ),
    );
  }
}
