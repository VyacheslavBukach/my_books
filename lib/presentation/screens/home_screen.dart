import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/di/locator.dart';

import '../ui_components/book_element.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = getIt<FirebaseAuthRepositoryImpl>().getCurrentUser();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
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
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          size: 35,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      'Hello, ${user?.email}',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'What do you want to read?',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BookElement(width: 150),
                      ),
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
                          child: Row(children: [
                            Icon(Icons.favorite),
                            Text('My favourite'),
                          ]),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Row(children: [
                            Icon(Icons.store),
                            Text('Store'),
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
                      'New Releases',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BookElement(width: 125),
                      ),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   showUnselectedLabels: false,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Favourite',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.store),
      //       label: 'Store',
      //     ),
      //   ],
      // ),

      // BlocListener<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     if (state is UnauthenticatedState) {
      //       Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(builder: (context) => const SignInScreen()),
      //         (route) => false,
      //       );
      //     }
      //   },
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'Email: \n ${user?.email}',
      //           style: const TextStyle(fontSize: 24),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 16),
      //         ElevatedButton(
      //           child: const Text('Sign Out'),
      //           onPressed: () {
      //             context.read<AuthBloc>().add(SignOutEvent());
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
