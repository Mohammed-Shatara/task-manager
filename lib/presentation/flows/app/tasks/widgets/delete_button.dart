import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../blocs/delete/delete_task_cubit.dart';

class DeleteButton extends StatelessWidget {
  final DeleteTaskCubit deleteTaskBloc;
  final VoidCallback deleteTask;

  const DeleteButton({
    required this.deleteTaskBloc,
    required this.deleteTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTaskCubit, DeleteTaskState>(
      bloc: deleteTaskBloc,
      listener: (context, deleteState) {
        if (deleteState.status == PageStatus.error) {
          toastification.show(
            context: context,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.bottomCenter,
            type: ToastificationType.error,
            title: Text(deleteState.error),
            autoCloseDuration: const Duration(seconds: 2),
          );
          deleteTaskBloc.resetErrorState();
        } else if (deleteState.status == PageStatus.success) {
          toastification.show(
            context: context,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.bottomCenter,
            type: ToastificationType.success,
            title: const Text('Task Deleted Successfully'),
            autoCloseDuration: const Duration(seconds: 2),
          );
          context.pop(true);
        }
      },
      child: TextButton(
        onPressed: deleteTask,
        child: Text(
          'Delete',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
