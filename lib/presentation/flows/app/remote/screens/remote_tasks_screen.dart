import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/presentation/flows/app/tasks/blocs/show_all/show_all_bloc.dart';
import 'package:task_manager/presentation/widgets/empty_icon.dart';

import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../tasks/widgets/task_item.dart';

class RemoteTaskScreen extends StatefulWidget {
  const RemoteTaskScreen({super.key});

  @override
  State<RemoteTaskScreen> createState() => _RemoteTaskScreenState();
}

class _RemoteTaskScreenState extends State<RemoteTaskScreen> {
  final bloc = locator<ShowAllBloc>();

  @override
  void initState() {
    bloc.getRemoteTasks();
    super.initState();
  }

  Future<void> onRefresh() async {
    return bloc.getRemoteTasks(loading: false);
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: () {
        bloc.getRemoteTasks();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Remote Tasks")),
        body: BlocBuilder<ShowAllBloc, ShowAllState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.remoteStatus == PageStatus.loading ||
                state.remoteStatus == PageStatus.init) {
              return Center(child: CircularProgressIndicator());
            }
            final tasks = state.remoteTasksList;
            if (tasks.isEmpty) {
              return Center(child: EmptyIcon());
            }
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskItem(
                    id: task.id.toString(),
                    status: task.status,
                    name: task.name,
                    description: task.description,
                    dueDate: task.dueDate,
                    userFullName: task.userFullName,
                    isRemote: true,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
