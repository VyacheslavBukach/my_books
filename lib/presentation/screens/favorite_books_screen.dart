import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/books_bloc/books_bloc.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/presentation/ui_components/book_list_item.dart';

import '../../domain/entities/book.dart';
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<List<Book>>(
                  stream:
                      getIt<GetFavouriteBooksUseCase>().getFavouriteBookIDs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong ${snapshot.error}");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var books = snapshot.requireData;

                    return ListView.separated(
                      itemCount: books.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) => BookListItem(
                        book: books[index],
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context).add(
                            BookClickedEvent(bookID: books[index].id),
                          );
                        },
                      ),
                    );
                  },
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
