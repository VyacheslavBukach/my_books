import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/presentation/screens/sign_in_screen.dart';
import 'package:my_books/presentation/screens/sign_up_screen.dart';
import 'package:my_books/presentation/ui_components/rounded_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 100,
            ),
            Text(
              AppLocalizations.of(context)?.welcome_to_mybooks ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(
                textStyle: Theme.of(context).textTheme.displayMedium,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)?.app_desc ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
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
