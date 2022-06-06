import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/presentation/blocs/favourite_books_bloc/favourite_books_bloc.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

class FavouriteBooksScreen extends StatelessWidget {
  const FavouriteBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavouriteBooksBloc>()..add(InitialEvent()),
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
        title: Text(AppLocalizations.of(context)?.favourites ?? ''),
      ),
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
                child: VerticalBookList(bookList: state.bookStream),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
