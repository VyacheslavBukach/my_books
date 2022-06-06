import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/entities/book.dart';
import 'package:my_books/presentation/blocs/book_detail_bloc/book_detail_bloc.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookID;

  const BookDetailScreen({
    Key? key,
    required this.bookID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BookDetailBloc>()..add(InitialEvent(id: bookID)),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookDetailBloc = BlocProvider.of<BookDetailBloc>(context);

    return BlocBuilder(
      bloc: bookDetailBloc,
      builder: (context, state) {
        if (state is InitialState) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        if (state is ShowingBookState) {
          if (state.book != null) {
            return _buildColumn(
              context,
              state.book!,
              state.likeStream,
            );
          }
        }

        if (state is ErrorBookState) {
          return Center(
            child: Text(state.error),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildColumn(
    BuildContext context,
    Book book,
    Stream<bool> likeStream,
  ) =>
      Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildTopContainer(context, book),
              _buildBoxContainer(context),
            ],
          ),
          _buildBottomContainer(context, book, likeStream),
        ],
      );

  Widget _buildTopContainer(
    BuildContext context,
    Book book,
  ) =>
      CachedNetworkImage(
        imageUrl: book.posterUrl,
        imageBuilder: (context, imageProvider) => Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildBoxContainer(BuildContext context) => Container(
        height: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  Widget _buildBottomContainer(
    BuildContext context,
    Book book,
    Stream<bool> likeStream,
  ) =>
      Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      book.title,
                      style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).colorScheme.onSurface,
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: likeStream,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Container();
                      } else {
                        bool isLiked = snapshot.requireData;

                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 1,
                          onPressed: () {
                            isLiked
                                ? BlocProvider.of<BookDetailBloc>(context)
                                    .add(UnlikedEvent(bookID: book.id))
                                : BlocProvider.of<BookDetailBloc>(context)
                                    .add(LikedEvent(bookID: book.id));
                          },
                          icon: Icon(
                            isLiked ? Icons.bookmark : Icons.bookmark_border,
                            color: isLiked
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary,
                          ),
                          iconSize: 40,
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                book.author,
                style: GoogleFonts.robotoSlab(
                  color: Theme.of(context).colorScheme.onSurface,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    book.popular.toString(),
                    style: GoogleFonts.robotoSlab(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 4,
                children: [
                  for (final genre in book.genre) Chip(label: Text(genre)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)?.about ?? '',
                style: GoogleFonts.robotoSlab(
                  color: Theme.of(context).colorScheme.onSurface,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.description,
                textAlign: TextAlign.justify,
                style: GoogleFonts.robotoSlab(
                  color: Theme.of(context).colorScheme.onSurface,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
}
