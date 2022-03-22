import 'package:flutter/material.dart';

import '../screens/main_screen.dart';

class RoundedButton extends StatelessWidget {
  final bool transparent;
  final Function() onPressed;
  final String label;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(300, 55)),
        backgroundColor:
            MaterialStateProperty.all(transparent ? kMainColor : Colors.white),
        foregroundColor:
            MaterialStateProperty.all(transparent ? Colors.white : kMainColor),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: transparent
                ? const BorderSide(color: Colors.white, width: 1)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
