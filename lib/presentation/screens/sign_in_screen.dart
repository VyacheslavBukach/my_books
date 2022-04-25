import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/blocs/login_bloc/login_bloc.dart';
import 'package:my_books/presentation/screens/home_screen.dart';

import '../../di/locator.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../ui_components/auth_text_field.dart';
import '../ui_components/rounded_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginUseCase: getIt<LoginUseCase>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Form(
        key: _formKey,
        child: BlocConsumer<LoginBloc, LoginState>(
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
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            }

            if (state is UnauthenticatedState) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context)?.sign_in_headline ?? '',
                          style: GoogleFonts.robotoSlab(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            textStyle:
                                Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AuthTextField(
                              controller: _emailController,
                              labelText:
                                  AppLocalizations.of(context)?.email ?? '',
                              icon: const Icon(Icons.email),
                              obscureText: false,
                            ),
                            AuthTextField(
                              controller: _passwordController,
                              obscureText: true,
                              labelText:
                                  AppLocalizations.of(context)?.password ?? '',
                              icon: const Icon(Icons.lock),
                            ),
                            RoundedButton(
                              transparent: true,
                              label:
                                  AppLocalizations.of(context)?.sign_in ?? '',
                              onPressed: () {
                                _authenticateWithEmailAndPassword(context);
                              },
                            ),
                            // TODO
                            // TextButton(
                            //   style: ButtonStyle(
                            //     overlayColor: MaterialStateProperty.all(
                            //         Colors.transparent),
                            //   ),
                            //   child: Text(AppLocalizations.of(context)
                            //           ?.forgot_password ??
                            //       ''),
                            //   onPressed: () {},
                            // ),
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticateWithEmailAndPassword(context) {
    final isValidForm = _formKey.currentState!.validate();
    if (isValidForm) {
      BlocProvider.of<LoginBloc>(context).add(
        SignInEvent(_emailController.text, _passwordController.text),
      );
    }
  }
}
