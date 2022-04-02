import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/books_bloc/books_bloc.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/presentation/ui_components/book_list_item.dart';

import '../../domain/entities/book.dart';
import '../../domain/usecases/firestore/get_favourite_books_usecase.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksBloc(
        getFavouriteBooksUseCase: getIt<GetFavouriteBooksUseCase>(),
      )..add(InitialBooksEvent()),
      child: BooksView(),
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
          if (state is LoadingBooksState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SuccessBooksState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder<List<Book>>(
                  future: getIt<GetFavouriteBooksUseCase>().getFavouriteBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.requireData;

                      return ListView.separated(
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) => BookListItem(
                          book: data[index],
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context).add(
                              BookClickedEvent(bookID: data[index].id),
                            );
                          },
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
