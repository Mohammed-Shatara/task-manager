import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di.dart';
import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../blocs/show_all/show_all_bloc.dart';

class TasksSwitcher extends StatefulWidget {
  const TasksSwitcher({super.key});

  @override
  State<TasksSwitcher> createState() => _TasksSwitcherState();
}

class _TasksSwitcherState extends State<TasksSwitcher> {
  final bloc = locator<ShowAllBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowAllBloc, ShowAllState>(
      bloc: bloc,
      builder: (context, state) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                bloc.switchListType();
                final userId = locator<AppBloc>().user?.id;
                if (userId != null && state.type == TasksType.user) {
                  bloc.getUserTasks(userId);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  state.type == TasksType.all ? 'All' : 'User',
                  style: TextTheme.of(context).bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
