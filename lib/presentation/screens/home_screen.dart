import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/auth/logout_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_new_books_usecase.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';
import 'package:my_books/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/presentation/screens/favorite_books_screen.dart';
import 'package:my_books/presentation/screens/main_screen.dart';
import 'package:my_books/presentation/screens/store_screen.dart';
import 'package:my_books/presentation/ui_components/horizontal_book_list.dart';

const _kLogout = 'logout';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        logoutUseCase: getIt<LogoutUseCase>(),
        getPopularBooksUseCase: getIt<GetPopularBooksUseCase>(),
        getNewBooksUseCase: getIt<GetNewBooksUseCase>(),
      )..add(InitialEvent()),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is UnauthenticatedState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }

          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
            return const CircularProgressIndicator();
          }

          if (state is AuthenticatedState) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [
                            0.1,
                            1.0,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    AppLocalizations.of(context)
                                            ?.what_do_you_want_to_read ??
                                        '',
                                    style: GoogleFonts.robotoSlab(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: kToolbarHeight,
                                child: PopupMenuButton<String>(
                                  offset: const Offset(0, kToolbarHeight * 0.8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  onSelected: (value) {
                                    switch (value) {
                                      case _kLogout:
                                        _signOutEvent(context);
                                        break;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem<String>(
                                      value: _kLogout,
                                      child: ListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal: -4,
                                          vertical: -4,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        minLeadingWidth: 8,
                                        leading: Icon(
                                          Icons.logout,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.54),
                                        ),
                                        title: Text(
                                          AppLocalizations.of(context)
                                                  ?.logout ??
                                              '',
                                          style: GoogleFonts.robotoSlab(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          Text(
                            AppLocalizations.of(context)?.popular ?? '',
                            style: GoogleFonts.robotoSlab(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: HorizontalBookList(
                              bookWidth: 150,
                              bookList: state.popularBooks,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.new_releases ?? '',
                            style: GoogleFonts.robotoSlab(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: HorizontalBookList(
                              bookWidth: 125,
                              bookList: state.releaseBooks,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  void _signOutEvent(context) {
    BlocProvider.of<HomeBloc>(context).add(SignOutEvent());
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: GoogleFonts.robotoSlab(
        textStyle: Theme.of(context).textTheme.labelLarge,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: GoogleFonts.robotoSlab(
        textStyle: Theme.of(context).textTheme.labelLarge,
        fontWeight: FontWeight.bold,
      ),
      unselectedItemColor: Theme.of(context).colorScheme.primary,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)?.favourites ?? '',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.store),
          label: AppLocalizations.of(context)?.store ?? '',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FavouriteBooksScreen(),
              ),
            );
            break;
          case 1:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StoreScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
