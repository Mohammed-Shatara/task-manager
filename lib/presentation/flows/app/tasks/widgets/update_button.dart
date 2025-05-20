import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onUpdateTask;

  const UpdateButton({required this.onUpdateTask, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onUpdateTask,
      child: Text(
        'Update',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
