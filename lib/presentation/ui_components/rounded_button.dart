import 'package:flutter/material.dart';

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
        backgroundColor: MaterialStateProperty.all(transparent
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary),
        foregroundColor: MaterialStateProperty.all(transparent
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: transparent
                ? BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  )
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
