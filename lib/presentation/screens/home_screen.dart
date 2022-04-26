import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';
import 'package:my_books/presentation/screens/favorite_books_screen.dart';
import 'package:my_books/presentation/screens/main_screen.dart';
import 'package:my_books/presentation/screens/store_screen.dart';

import '../../domain/usecases/auth/get_current_user_email_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/firestore/get_new_books_usecase.dart';
import '../ui_components/horizontal_book_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        getCurrentUserEmailUseCase: getIt<GetCurrentUserEmailUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        getPopularBooksUseCase: getIt<GetPopularBooksUseCase>(),
        getNewBooksUseCase: getIt<GetNewBooksUseCase>(),
      )..add(InitialEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
                        top: 8,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 9,
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        AppLocalizations.of(context)?.welcome ??
                                            '',
                                    style: GoogleFonts.robotoSlab(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    children: [
                                      const TextSpan(text: ', '),
                                      TextSpan(text: state.email),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    _signOutEvent(context);
                                  },
                                  icon: Icon(
                                    Icons.logout,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)
                                    ?.what_do_you_want_to_read ??
                                '',
                            style: GoogleFonts.robotoSlab(
                              color: Theme.of(context).colorScheme.onPrimary,
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavouriteBooksScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.favorite),
                                label: Text(
                                  AppLocalizations.of(context)?.favourites ??
                                      '',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const StoreScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.store),
                                label: Text(
                                  AppLocalizations.of(context)?.store ?? '',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  void _signOutEvent(context) {
    BlocProvider.of<HomeBloc>(context).add(SignOutEvent());
  }
}
