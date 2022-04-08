import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/books_bloc/books_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

import '../../domain/usecases/firestore/check_book_like_usecase.dart';
import '../../domain/usecases/firestore/get_favourite_books_usecase.dart';

class FavouriteBooksScreen extends StatelessWidget {
  const FavouriteBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksBloc(
        checkBookLikeUseCase: getIt<CheckBookLikeUseCase>(),
      ),
      child: const BooksView(),
    );
  }
}

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: BlocConsumer<BooksBloc, BooksState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ShowingBooksState) {
            return SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: VerticalBookList(
                  books: getIt<GetFavouriteBooksUseCase>().getFavouriteBooks(),
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
