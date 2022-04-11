import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final bool? obscureText;
  final Icon? icon;

  const AuthTextField({
    Key? key,
    this.obscureText,
    required this.labelText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        style: const TextStyle(fontSize: 18),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
