import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/register_bloc/register_bloc.dart';
import 'package:my_books/presentation/screens/home_screen.dart';

import '../../di/locator.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../ui_components/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.register ?? ''),
        ),
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }

            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UnauthenticatedState) {
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
    BlocProvider.of<RegisterBloc>(context).add(
      SignUpEvent("hi1@mail.ru", "123456"),
    );
  }
}
