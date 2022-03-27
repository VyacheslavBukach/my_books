import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/firestore/get_popular_books_usecase.dart';
import 'package:my_books/presentation/screens/book_detail_screen.dart';
import 'package:my_books/presentation/screens/main_screen.dart';

import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/firestore/get_new_books_usecase.dart';
import '../ui_components/book_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        logoutUseCase: getIt<LogoutUseCase>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = getIt<FirebaseAuthRepositoryImpl>().currentUser;

    return Scaffold(
      backgroundColor: kMainColor,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is UnauthenticatedState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticatedState) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hello, ${user?.email}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _signOut(context);
                                },
                                icon: const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)
                                    ?.what_do_you_want_to_read ??
                                '',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)?.popular ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: BookList(
                              bookWidth: 150,
                              usecase: getIt<GetPopularBooksUseCase>()
                                  .getPopularBooks(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BookDetailScreen(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.favorite),
                                    Text(AppLocalizations.of(context)
                                            ?.my_favourite ??
                                        ''),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.store),
                                    Text(AppLocalizations.of(context)?.store ??
                                        ''),
                                  ],
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
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.new_releases ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: BookList(
                              bookWidth: 125,
                              usecase:
                                  getIt<GetNewBooksUseCase>().getNewBooks(),
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

  void _signOut(context) {
    BlocProvider.of<HomeBloc>(context).add(SignOutEvent());
  }
}
