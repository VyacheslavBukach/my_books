import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/presentation/screens/book_detail_screen.dart';

class SearchResultItem extends StatelessWidget {
  final Book book;

  const SearchResultItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white60,
                Colors.white10,
              ],
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(width: 2, color: Colors.white30),
          ),
          child: ListTile(
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
          ),
        ),
      ),
    );
  }
}
