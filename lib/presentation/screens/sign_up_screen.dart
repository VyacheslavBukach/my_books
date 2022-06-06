import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/di/locator.dart';
import 'package:my_books/domain/usecases/auth/register_usecase.dart';
import 'package:my_books/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:my_books/presentation/screens/home_screen.dart';
import 'package:my_books/presentation/ui_components/auth_text_field.dart';
import 'package:my_books/presentation/ui_components/rounded_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: BlocConsumer<RegisterBloc, RegisterState>(
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Text(
                    state.error,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UnauthenticatedState) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16.0),
                        child: state.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              )
                            : Text(
                                AppLocalizations.of(context)
                                        ?.sign_up_headline ??
                                    '',
                                style: GoogleFonts.robotoSlab(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 30,
                          bottom: 20,
                        ),
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
                                  AppLocalizations.of(context)?.register ?? '',
                              onPressed: () {
                                _authenticateWithEmailAndPassword(context);
                              },
                            ),
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
      BlocProvider.of<RegisterBloc>(context).add(
        SignUpEvent(_emailController.text, _passwordController.text),
      );
    }
  }
}
