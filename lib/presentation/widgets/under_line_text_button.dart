import 'package:flutter/material.dart';

class UnderLineTextButton extends StatelessWidget {
  const UnderLineTextButton({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(3),
      child: Text(
        title,
        style: TextTheme.of(context).bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          decorationColor: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
