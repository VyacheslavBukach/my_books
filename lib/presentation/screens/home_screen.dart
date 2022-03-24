import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/firestore/get_books_usecase.dart';
import 'package:my_books/presentation/screens/main_screen.dart';

import '../../domain/entities/book.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../ui_components/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        logoutUseCase: getIt<LogoutUseCase>(),
        getBooksUseCase: getIt<GetBooksUseCase>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = getIt<FirebaseAuthRepositoryImpl>().getCurrentUser();

  @override
  void initState() {
    super.initState();
    // _getBooks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF10acef),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                          Text(
                            'Hello, ${user?.email}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
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
                          const Expanded(
                            child: BookList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {},
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
                                child: Row(children: [
                                  const Icon(Icons.store),
                                  Text(AppLocalizations.of(context)?.store ??
                                      ''),
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
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
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  const BookCard(width: 125),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
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

  void _getBooks(context) {
    BlocProvider.of<HomeBloc>(context).add(LoadBooksEvent());
  }
}

class BookList extends StatelessWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference horrorCollection = FirebaseFirestore.instance
        .collection('books')
        .doc('genres')
        .collection('horror')
        .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data() ?? {}),
          toFirestore: (book, _) => book.toJson(),
        );

    return FutureBuilder<QuerySnapshot>(
      future: horrorCollection.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          snapshot.data?.docs.forEach((doc) {
            print(doc.data());
          });

          return Text("Full");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // return ListView.builder(
    //   itemCount: 5,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) => const BookCard(width: 150),
    // );
  }
}
