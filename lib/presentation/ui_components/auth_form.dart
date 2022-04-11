import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/domain/entities/auth_type.dart';
import 'package:my_books/presentation/ui_components/rounded_button.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import '../../blocs/register_bloc/register_bloc.dart';
import 'auth_text_field.dart';

class AuthForm extends StatefulWidget {
  final String buttonLabel;
  final AuthType authType;

  const AuthForm({
    Key? key,
    required this.buttonLabel,
    required this.authType,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            labelText: AppLocalizations.of(context)?.email ?? '',
            icon: const Icon(Icons.email),
            obscureText: false,
          ),
          AuthTextField(
            obscureText: true,
            labelText: AppLocalizations.of(context)?.password ?? '',
            icon: const Icon(Icons.lock),
          ),
          RoundedButton(
            transparent: true,
            label: widget.buttonLabel,
            onPressed: () {
              _authenticateWithEmailAndPassword(context);
            },
          ),
        ],
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    final isValidForm = _formKey.currentState!.validate();
    if (isValidForm) {
      if (widget.authType == AuthType.login) {
        BlocProvider.of<LoginBloc>(context).add(
          SignInEvent("hi@mail.ru", "123456"),
        );
      } else {
        BlocProvider.of<RegisterBloc>(context).add(
          SignUpEvent("hi1@mail.ru", "123456"),
        );
      }
    }
  }
}
