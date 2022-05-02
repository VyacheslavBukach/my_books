import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/presentation/ui_components/search_result_item.dart';
import 'package:my_books/themes.dart';

import '../../blocs/search_bloc/search_bloc.dart';
import '../../domain/entities/book.dart';

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
                    child: Column(
                      children: [
                        _buildResultWidget(context, books.length),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            itemCount: books.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) =>
                                SearchResultItem(book: books[index]),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.no_found ?? '',
                      style: GoogleFonts.robotoSlab(
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
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

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Themes.lightTheme.copyWith(
      scaffoldBackgroundColor: Theme.of(context).colorScheme.background,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Theme.of(context).colorScheme.background,
        cursorColor: Theme.of(context).colorScheme.onPrimary,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6:
                TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
    );
  }

  Widget _buildResultWidget(BuildContext context, int size) => RichText(
        text: TextSpan(
          text: AppLocalizations.of(context)?.found ?? '',
          children: [
            const TextSpan(text: ': '),
            TextSpan(text: '$size'),
          ],
          style: GoogleFonts.robotoSlab(
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
}
