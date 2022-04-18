import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/presentation/screens/sign_in_screen.dart';
import 'package:my_books/presentation/screens/sign_up_screen.dart';
import 'package:my_books/presentation/ui_components/rounded_button.dart';

const kMainColor = Color(0xFF10acef);

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.book_outlined,
              size: 100,
              color: Colors.white,
            ),
            Text(
              AppLocalizations.of(context)?.welcome_to_mybooks ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)?.app_desc ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 100),
            RoundedButton(
              transparent: false,
              label: AppLocalizations.of(context)?.create_account ?? '',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            RoundedButton(
              transparent: true,
              label: AppLocalizations.of(context)?.sign_in ?? '',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
