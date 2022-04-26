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
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
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
