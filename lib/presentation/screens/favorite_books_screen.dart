import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

import '../../blocs/favourite_books_bloc/favourite_books_bloc.dart';
import '../../domain/usecases/firestore/check_book_like_usecase.dart';
import '../../domain/usecases/firestore/get_favourite_books_usecase.dart';

class FavouriteBooksScreen extends StatelessWidget {
  const FavouriteBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteBooksBloc(
        checkBookLikeUseCase: getIt<CheckBookLikeUseCase>(),
        getFavouriteBooksUseCase: getIt<GetFavouriteBooksUseCase>(),
      )..add(InitialEvent()),
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
      body: BlocConsumer<FavouriteBooksBloc, FavouriteBooksState>(
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
                child: VerticalBookList(bookStream: state.bookStream),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
