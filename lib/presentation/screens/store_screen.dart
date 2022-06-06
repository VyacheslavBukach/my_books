import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/entities/genre.dart';
import 'package:my_books/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:my_books/presentation/blocs/store_bloc/store_bloc.dart';
import 'package:my_books/presentation/ui_components/book_search_delegate.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<StoreBloc>()..add(FilterByDefaultEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

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
                    BookSearchDelegate(BlocProvider.of<SearchBloc>(context)),
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
                      return VerticalBookList(bookList: state.bookStream);
                    }

                    if (state is FilteredStoreState) {
                      return VerticalBookList(bookList: state.bookStream);
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
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                selectedColor: Theme.of(context).colorScheme.primary,
                pressElevation: 0,
                backgroundColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                label: Text(genre.name),
                labelStyle: TextStyle(
                  color: _filters.contains(genre.name)
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
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
