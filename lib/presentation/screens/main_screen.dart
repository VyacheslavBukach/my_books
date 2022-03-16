import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_books/presentation/screens/sign_in_screen.dart';
import 'package:my_books/presentation/screens/sign_up_screen.dart';

const _kMainColor = Color(0xFF10acef);

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kMainColor,
      body: Column(
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
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)?.app_desc ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(300, 50)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(_kMainColor),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)?.create_account ?? ''),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(300, 50)),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(_kMainColor),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)?.sign_in ?? ''),
          ),
        ],
      ),
    );
  }
}
