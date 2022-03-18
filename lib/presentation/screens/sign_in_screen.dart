import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/blocs/login_bloc/login_bloc.dart';
import 'package:my_books/presentation/screens/home_screen.dart';
import 'package:my_books/presentation/ui_components/rounded_button.dart';

import '../../di/locator.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../ui_components/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginUseCase: getIt<LoginUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.login ?? ''),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
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
                SnackBar(content: Text(state.error)),
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
                      icon: const Icon(Icons.email),
                    ),
                    AuthTextField(
                      obscureText: true,
                      labelText: AppLocalizations.of(context)?.password ?? '',
                      icon: const Icon(Icons.lock),
                    ),
                    RoundedButton(
                      transparent: true,
                      label: AppLocalizations.of(context)?.login ?? '',
                      onPressed: () {
                        _authenticateWithEmailAndPassword(context);
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
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
    BlocProvider.of<LoginBloc>(context).add(
      SignInEvent("hi@mail.ru", "123456"),
    );
  }
}
