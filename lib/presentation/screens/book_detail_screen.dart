import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/blocs/book_detail_bloc/book_detail_bloc.dart';

import '../../di/locator.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecases/firestore/add_book_to_favourite_usecase.dart';
import '../../domain/usecases/firestore/check_book_like_usecase.dart';
import '../../domain/usecases/firestore/delete_book_from_favourite_usecase.dart';
import '../../domain/usecases/firestore/get_book_by_id_usecase.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookID;

  const BookDetailScreen({
    Key? key,
    required this.bookID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailBloc(
        getBookByIDUseCase: getIt<GetBookByIDUseCase>(),
        addBookToFavouriteUseCase: getIt<AddBookToFavouriteUseCase>(),
        deleteBookFromFavouriteUseCase: getIt<DeleteBookFromFavouriteUseCase>(),
        checkBookLikeUseCase: getIt<CheckBookLikeUseCase>(),
      )..add(InitialEvent(id: bookID)),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
        ),
        body: const BookDetailView(),
      ),
    );
  }
}

class BookDetailView extends StatelessWidget {
  const BookDetailView({Key? key}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopContainer(context, book, likeStream),
          _buildBottomContainer(context, book),
        ],
      );

  Widget _buildTopContainer(
    BuildContext context,
    Book book,
    Stream<bool> likeStream,
  ) =>
      Expanded(
        flex: 1,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(book.posterUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: StreamBuilder<bool>(
                stream: likeStream,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    bool isLiked = snapshot.requireData;

                    return IconButton(
                      splashRadius: 1,
                      alignment: Alignment.bottomRight,
                      onPressed: () {
                        isLiked
                            ? BlocProvider.of<BookDetailBloc>(context)
                                .add(UnlikedEvent(bookID: book.id))
                            : BlocProvider.of<BookDetailBloc>(context)
                                .add(LikedEvent(bookID: book.id));
                      },
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey.shade400,
                      ),
                      iconSize: 60,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildBottomContainer(BuildContext context, Book book) => Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: GoogleFonts.robotoSlab(
                    color: Theme.of(context).colorScheme.onSurface,
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontWeight: FontWeight.bold,
                  ),
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
                    Text(book.popular.toString()),
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
              ],
            ),
          ),
        ),
      );
}
