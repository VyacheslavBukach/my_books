import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/store_bloc/store_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../domain/entities/book.dart';
import '../ui_components/book_list_item.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(
        getAllBooksUseCase: getIt<GetAllBooksUseCase>(),
      ),
      child: const StoreView(),
    );
  }
}

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: StreamBuilder<List<Book>>(
            stream: getIt<GetAllBooksUseCase>().getAllBooks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
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
      ),
    );
  }
}
