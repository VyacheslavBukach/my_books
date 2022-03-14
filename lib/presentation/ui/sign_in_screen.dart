import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_books/presentation/ui/books_screen.dart';

import '../widgets/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.login ?? ''),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BooksScreen(),
              ),
            );
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UnAuthenticatedState) {
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
                      child: Text(
                        AppLocalizations.of(context)?.login ?? '',
                      ),
                      onPressed: () {
                        _authenticateWithEmailAndPassword(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context)?.register ?? ''),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Text(
                          AppLocalizations.of(context)?.forgot_password ?? ''),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignInRequested("hi@mail.ru", "123456"),
    );
  }
}
