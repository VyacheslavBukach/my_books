import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: posterUrl,
          width: width,
          imageBuilder: (context, imageProvider) => Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onTap: onClick,
      ),
    );
  }
}
