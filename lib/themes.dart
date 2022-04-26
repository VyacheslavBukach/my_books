import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData();

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
    ).copyWith(),
  );
}
