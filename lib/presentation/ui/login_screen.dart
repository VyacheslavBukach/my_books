import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/domain/usecases/auth/login_usecase.dart';
import 'package:my_books/presentation/widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginUseCase _loginUseCase = LoginUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.login ?? ''),
      ),
      body: Container(
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
              onPressed: () async {
                _loginUseCase.call("hi@mail.ru", "123456");
              },
            ),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)?.register ?? ''),
              onPressed: () {},
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)?.forgot_password ?? ''),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
