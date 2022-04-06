import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/book_detail_bloc/book_detail_bloc.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';

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
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocProvider(
      create: (context) => BookDetailBloc(
        getBookByIDUseCase: getIt<GetBookByIDUseCase>(),
        addBookToFavouriteUseCase: getIt<AddBookToFavouriteUseCase>(),
        deleteBookFromFavouriteUseCase: getIt<DeleteBookFromFavouriteUseCase>(),
      )..add(InitialBookDetailEvent(id: bookID)),
      child: WillPopScope(
        onWillPop: () async {
          homeBloc.add(BackPressedEvent());
          return true;
        },
        child: const Scaffold(
          backgroundColor: Colors.white,
          body: BookDetailView(),
        ),
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
        if (state is LoadingBookState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SuccessBookState) {
          return _buildColumn(context, state.book);
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

  Widget _buildColumn(BuildContext context, Book? book) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopContainer(context, book),
          _buildBottomContainer(context, book),
        ],
      );

  Widget _buildTopContainer(BuildContext context, Book? book) => Expanded(
        flex: 1,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(book?.posterUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: StreamBuilder<bool>(
                stream:
                    getIt<CheckBookLikeUseCase>().checkBookLike(book?.id ?? ''),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong ${snapshot.error}");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  bool isLiked = snapshot.requireData;

                  return IconButton(
                    alignment: Alignment.bottomRight,
                    color: isLiked ? Colors.red : Colors.white,
                    onPressed: () {
                      isLiked
                          ? BlocProvider.of<BookDetailBloc>(context)
                              .add(UnlikedEvent(bookID: book?.id ?? ''))
                          : BlocProvider.of<BookDetailBloc>(context)
                              .add(LikedEvent(bookID: book?.id ?? ''));
                    },
                    icon: const Icon(Icons.favorite),
                    iconSize: 60,
                  );
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildBottomContainer(BuildContext context, Book? book) => Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book?.title ?? '',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  book?.author ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    Text(book?.popular.toString() ?? ''),
                  ],
                ),
                Text(AppLocalizations.of(context)?.about ?? ''),
                Text(book?.description ?? ''),
              ],
            ),
          ),
        ),
      );
}
