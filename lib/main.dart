import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/presentation/login_screen.dart';

void main() {
  runApp(
    MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)?.app_name ?? '',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginScreen(),
    ),
  );
}
