import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    this.obscureText,
    required this.labelText,
  }) : super(key: key);

  final String labelText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
