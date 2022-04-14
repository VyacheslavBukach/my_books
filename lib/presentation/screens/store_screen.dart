import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/blocs/store_bloc/store_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/entities/genre.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';
import 'package:my_books/presentation/screens/main_screen.dart';
import 'package:my_books/presentation/ui_components/vertical_book_list.dart';

import '../../domain/usecases/firestore/get_filtered_books_usecase.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(
        getAllBooksUseCase: getIt<GetAllBooksUseCase>(),
        getFilteredBooksUseCase: getIt<GetFilteredBooksUseCase>(),
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
                  left: 10,
                  right: 10,
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
                selectedColor: kMainColor,
                pressElevation: 0,
                shape: const StadiumBorder(side: BorderSide()),
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
