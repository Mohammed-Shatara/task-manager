import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText(
              'Task Manager',
              textStyle: TextTheme.of(
                context,
              ).headlineMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              duration: const Duration(milliseconds: 1500),
            ),
            FadeAnimatedText(
              'Manage Smarter',
              textStyle: TextTheme.of(
                context,
              ).headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              duration: const Duration(milliseconds: 1500),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 800),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ),
    );
  }
}
