import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_books/presentation/screens/books_screen.dart';

import '../ui_components/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.register ?? ''),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BooksScreen(),
              ),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UnAuthenticated) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTextField(
                    labelText: AppLocalizations.of(context)?.email ?? '',
                  ),
                  AuthTextField(
                    obscureText: true,
                    labelText: AppLocalizations.of(context)?.password ?? '',
                  ),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)?.register ?? ''),
                    onPressed: () {
                      _authenticateWithEmailAndPassword(context);
                    },
                  ),
                  TextButton(
                    child: Text(AppLocalizations.of(context)?.login ?? ''),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

  void _authenticateWithEmailAndPassword(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpRequested("hi1@mail.ru", "123456"),
    );
  }
}