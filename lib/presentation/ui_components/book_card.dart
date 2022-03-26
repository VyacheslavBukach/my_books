import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final String author;
  final String posterUrl;

  const BookCard({
    Key? key,
    this.width,
    this.height,
    required this.title,
    required this.author,
    required this.posterUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(posterUrl),
              fit: BoxFit.fitHeight,
              // alignment: Alignment.center,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title),
                Text(author),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
