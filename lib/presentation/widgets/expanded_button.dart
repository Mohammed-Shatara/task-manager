import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : () {},

        child:
            isLoading
                ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                : AutoSizeText(title, maxLines: 1),
      ),
    );
  }
}
