import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/show_all/show_all_bloc.dart';

import '../../../../../app/di.dart';
import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../../core/navigation/routes.dart';
import '../blocs/create/create_task_cubit.dart';

class TaskItem extends StatefulWidget {
  final String name;
  final String id;
  final String status;
  final DateTime dueDate;
  final String? userFullName;
  final String? description;

  const TaskItem({
    super.key,
    required this.name,
    required this.status,
    required this.dueDate,
    this.userFullName,
    this.description,
    required this.id,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // final shouldAnimate = !widget.animatedIndexes.contains(widget.index);
    // if (shouldAnimate) widget.animatedIndexes.add(widget.index);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // if (shouldAnimate) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
    // } else {
    //   _controller.value = 1.0;
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dueDateStr = DateFormat.yMMMd().format(widget.dueDate);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              await context.push(
                RoutesPath.taskDetailsScreen(widget.id.toString()),
              );
              final userId = locator<AppBloc>().user?.id;
              if (userId != null) {
                locator<ShowAllBloc>().getUserTasks(userId);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (widget.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      widget.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                if (widget.userFullName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      'Owner: ${widget.userFullName!}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        TaskStatusExtension.fromName(widget.status).label,
                      ),
                      backgroundColor: TaskStatusExtension.fromName(
                        widget.status,
                      ).bgColor(context),
                      labelStyle: TextStyle(
                        color: TaskStatusExtension.fromName(
                          widget.status,
                        ).color(context),
                      ),
                    ),
                    Text(
                      "Due: $dueDateStr",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
