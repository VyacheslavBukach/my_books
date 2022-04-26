import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list_item.dart';

import '../../blocs/search_bloc/search_bloc.dart';
import '../../domain/entities/book.dart';
import '../screens/book_detail_screen.dart';

class BookSearchDelegate extends SearchDelegate {
  String selectedResult = '';
  final SearchBloc searchBloc;

  BookSearchDelegate(this.searchBloc);

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
