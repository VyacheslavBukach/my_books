import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final double? width;
  final String posterUrl;

  const BookCard({
    Key? key,
    this.width,
    required this.posterUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.5),
        child: Ink.image(
          width: width,
          image: NetworkImage(posterUrl),
          fit: BoxFit.fitHeight,
        ),
        onTap: () {},
      ),
    );
  }
}
