import 'package:flutter/material.dart';

class HorizontalBookListItem extends StatelessWidget {
  final double? width;
  final String posterUrl;
  final Function() onClick;

  const HorizontalBookListItem({
    Key? key,
    this.width,
    required this.posterUrl,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.5),
        child: Ink.image(
          width: width,
          image: NetworkImage(posterUrl),
          fit: BoxFit.cover,
        ),
        onTap: onClick,
      ),
    );
  }
}
