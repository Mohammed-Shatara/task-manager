import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/navigation/routes.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/delete/delete_task_cubit.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/show/show_task_cubit.dart';

import '../widgets/delete_button.dart';
import '../widgets/task_details_card.dart';
import '../widgets/update_button.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final bloc = locator<ShowTaskCubit>();
  final deleteTaskBloc = locator<DeleteTaskCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = GoRouterState.of(context).pathParameters['taskId'];
      bloc.getSingleTaskData(int.parse(id!));
    });
    super.initState();
  }

  void onUpdateTask() async {
    final id = GoRouterState.of(context).pathParameters['taskId'];
    final result = await context.push(RoutesPath.updateTaskScreen(id!));
    if (result != null && result is bool && result) {
      bloc.getSingleTaskData(int.parse(id));
    }
  }

  void deleteTask() {
    final id = GoRouterState.of(context).pathParameters['taskId'];
    deleteTaskBloc.deleteTask(int.parse(id!));
  }

  @override
  void dispose() {
    bloc.close();
    deleteTaskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTaskCubit, ShowState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == PageStatus.init ||
            state.status == PageStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == PageStatus.success) {
          final task = state.taskModel!;
          final isMe = locator<AppBloc>().user?.id == task.userId;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Task Details'),
              actions:
                  isMe
                      ? [
                        UpdateButton(onUpdateTask: onUpdateTask),
                        DeleteButton(
                          deleteTaskBloc: deleteTaskBloc,
                          deleteTask: deleteTask,
                        ),
                      ]
                      : null,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 42),
              child: TaskDetailsCard(task: task),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
