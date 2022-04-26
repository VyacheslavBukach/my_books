import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final Icon? icon;
  final TextEditingController controller;

  const AuthTextField({
    Key? key,
    required this.obscureText,
    required this.labelText,
    this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelText: labelText,
        ),
        validator: (value) {
          if (obscureText) {
            if (value != null && value.length < 6) {
              return AppLocalizations.of(context)?.invalid_password ?? '';
            } else {
              return null;
            }
          } else {
            if (value != null && !EmailValidator.validate(value)) {
              return AppLocalizations.of(context)?.invalid_email ?? '';
            } else {
              return null;
            }
          }
        },
      ),
    );
  }
}
