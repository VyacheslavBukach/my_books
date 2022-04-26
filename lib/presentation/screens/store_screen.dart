import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/search_bloc/search_bloc.dart';
import 'package:my_books/blocs/store_bloc/store_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/entities/genre.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

import '../../domain/entities/book.dart';
import '../../domain/usecases/firestore/get_books_from_search_usecase.dart';
import '../../domain/usecases/firestore/get_filtered_books_usecase.dart';
import '../ui_components/vertical_book_list_item.dart';
import 'book_detail_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoreBloc(
            getAllBooksUseCase: getIt<GetAllBooksUseCase>(),
            getFilteredBooksUseCase: getIt<GetFilteredBooksUseCase>(),
          )..add(FilterByDefaultEvent()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            getBooksFromSearchUseCase: getIt<GetBooksFromSearchUseCase>(),
          ),
        ),
      ],
      child: const StoreView(),
    );
  }
}

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.store ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    MySearchDelegate(BlocProvider.of<SearchBloc>(context)),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const FilterContainer(),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: BlocBuilder(
                  bloc: BlocProvider.of<StoreBloc>(context),
                  builder: (context, state) {
                    if (state is DefaultStoreState) {
                      return VerticalBookList(bookStream: state.bookStream);
                    }

                    if (state is FilteredStoreState) {
                      return VerticalBookList(bookStream: state.bookStream);
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ],
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
                checkmarkColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                selectedColor: Theme.of(context).colorScheme.secondaryContainer,
                pressElevation: 0,
                backgroundColor: Theme.of(context).colorScheme.outline,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                label: Text(genre.name),
                labelStyle: TextStyle(
                  color: _filters.contains(genre.name)
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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

class MySearchDelegate extends SearchDelegate {
  String selectedResult = '';
  final SearchBloc searchBloc;

  MySearchDelegate(this.searchBloc);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    selectedResult = query;
    searchBloc.add(InitialSearchEvent(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState state) {
        if (state is SearchSuccessState) {
          return StreamBuilder<List<Book>>(
            stream: state.bookStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text(
                    AppLocalizations.of(context)?.something_went_wrong ?? '');
              } else {
                var books = snapshot.requireData;

                if (books.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: ListView.separated(
                      itemCount: books.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) => VerticalBookListItem(
                        book: books[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(
                                bookID: books[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(AppLocalizations.of(context)?.no_found ?? ''),
                  );
                }
              }
            },
          );
        }

        return Text(AppLocalizations.of(context)?.something_went_wrong ?? '');
      },
    );
  }
}
