import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/store_bloc/store_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/entities/genre.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecases/firestore/get_filtered_books_usecase.dart';
import '../ui_components/book_list_item.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(
        getAllBooksUseCase: getIt<GetAllBooksUseCase>(),
        getFilteredBooks: getIt<GetFilteredBooks>(),
      )..add(FilterByDefaultEvent()),
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
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            children: [
              const FilterContainer(),
              Expanded(
                child: BlocBuilder(
                  bloc: BlocProvider.of<StoreBloc>(context),
                  builder: (context, state) {
                    if (state is DefaultStoreState) {
                      return BookContainer(
                        books: getIt<GetAllBooksUseCase>().getAllBooks(),
                      );
                    }

                    if (state is FilteredStoreState) {
                      return BookContainer(
                        books: getIt<GetFilteredBooks>()
                            .getFilteredBooks(state.genres),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterContainer extends StatefulWidget {
  const FilterContainer({Key? key}) : super(key: key);

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  final List<String> _filters = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final genre in Genre.values)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FilterChip(
                label: Text(genre.name),
                selected: _filters.contains(genre.name),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _filters.add(genre.name);
                      BlocProvider.of<StoreBloc>(context)
                          .add(FilterByGenresEvent(genres: _filters));
                    } else {
                      _filters.remove(genre.name);
                      if (_filters.isNotEmpty) {
                        BlocProvider.of<StoreBloc>(context)
                            .add(FilterByGenresEvent(genres: _filters));
                      } else {
                        BlocProvider.of<StoreBloc>(context)
                            .add(FilterByDefaultEvent());
                      }
                    }
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

class BookContainer extends StatelessWidget {
  final Stream<List<Book>> books;

  const BookContainer({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: books,
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
          separatorBuilder: (context, index) => const SizedBox(height: 10),
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
    );
  }
}
