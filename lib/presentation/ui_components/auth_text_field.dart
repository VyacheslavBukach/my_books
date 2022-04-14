import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
        style: const TextStyle(fontSize: 18),
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
              return 'Enter min 6 characters';
            } else {
              return null;
            }
          } else {
            if (value != null && !EmailValidator.validate(value)) {
              return 'Enter a valid email';
            } else {
              return null;
            }
          }
        },
      ),
    );
  }
}
