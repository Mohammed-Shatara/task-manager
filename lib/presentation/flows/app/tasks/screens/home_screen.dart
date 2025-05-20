import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/navigation/routes.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/show_all/show_all_bloc.dart';
import 'package:task_manager/presentation/widgets/empty_icon.dart';

import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../widgets/task_item.dart';
import '../widgets/tasks_switcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = locator<ShowAllBloc>();

  @override
  void initState() {
    bloc.watchTasks();
    final userId = locator<AppBloc>().user?.id;
    if (userId != null) {
      bloc.getUserTasks(userId);
    }
    super.initState();
  }

  void onCreateTask() async {
    await context.push(RoutesPath.createTaskScreen);

    final userId = locator<AppBloc>().user?.id;
    if (userId != null) {
      bloc.getUserTasks(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks"), actions: [TasksSwitcher()]),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTask,
        child: Icon(Icons.create),
      ),
      body: BlocBuilder<ShowAllBloc, ShowAllState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.displayedStatus == PageStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          final tasks = state.displayedList;
          if (tasks.isEmpty) {
            return Center(child: EmptyIcon());
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = state.displayedList[index];
              return TaskItem(
                id: task.id.toString(),
                status: task.status,
                name: task.name,
                description: task.description,
                dueDate: task.dueDate,
                userFullName: task.userFullName,
              );
            },
          );
        },
      ),
    );
  }
}
