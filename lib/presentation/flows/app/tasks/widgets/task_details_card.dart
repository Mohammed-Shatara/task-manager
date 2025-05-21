import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/task_model.dart';
import '../blocs/create/create_task_cubit.dart';

class TaskDetailsCard extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsCard({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final dueDateStr = DateFormat.yMMMd().add_jm().format(task.dueDate);
    final status = TaskStatusExtension.fromName(task.status);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(task: task),
              if (task.description?.trim().isNotEmpty ?? false)
                _Description(description: task.description!),
              const SizedBox(height: 28),
              _StatusAndDueDate(status: status, dueDateStr: dueDateStr),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TaskModel task;

  const _Header({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AutoSizeText(
            task.name,
            maxLines: 6,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(
          Icons.task_alt_rounded,
          color: theme.colorScheme.primary,
          size: 28,
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  final String description;

  const _Description({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          AutoSizeText(
            description,
            maxLines: 10,
            textAlign: TextAlign.justify,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,

            ),
          ),
        ],
      ),
    );
  }
}

class _StatusAndDueDate extends StatelessWidget {
  final TaskStatus status;
  final String dueDateStr;

  const _StatusAndDueDate({required this.status, required this.dueDateStr});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Chip(
          label: Text(status.label),
          backgroundColor: status.bgColor(context),
          labelStyle: TextStyle(
            color: status.color(context),
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        ),
        const Spacer(),
        Row(
          children: [
            const Icon(Icons.calendar_today_rounded, size: 20),
            const SizedBox(width: 6),
            Text(
              dueDateStr,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
