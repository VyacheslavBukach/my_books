import 'package:flutter/material.dart';

class BookElement extends StatelessWidget {
  final double? width;
  final double? height;

  const BookElement({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        child: Icon(
          Icons.star,
        ),
      ),
    );
  }
}
