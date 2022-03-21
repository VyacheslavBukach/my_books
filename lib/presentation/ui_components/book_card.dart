import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final double? width;
  final double? height;

  const BookCard({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Card(
        child: Icon(
          Icons.menu_book,
          size: 100,
        ),
      ),
    );
  }
}
