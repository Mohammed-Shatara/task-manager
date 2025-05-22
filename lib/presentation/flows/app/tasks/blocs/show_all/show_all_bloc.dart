import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/param/no_param.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/domain/use_cases/tasks/get_user_tasks_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/watch_tasks_use_case.dart';

import '../../../../../../domain/use_cases/tasks/get_remote_tasks_use_case.dart';

part 'show_all_event.dart';

part 'show_all_state.dart';

class ShowAllBloc extends Bloc<ShowAllEvent, ShowAllState> {
  final WatchTasksWithUsersUseCase watchTasksUseCase;
  final GetUserTaskUseCase getUserTaskUseCase;
  final GetRemoteTaskUseCase getRemoteTaskUseCase;

  ShowAllBloc({
    required this.watchTasksUseCase,
    required this.getUserTaskUseCase,
    required this.getRemoteTaskUseCase,
  }) : super(ShowAllState()) {
    on<SwitchListEvent>(_onSwitchDisplayedTasks);
    on<WatchTasksEvent>(_onWatchTasks);
    on<GetUserTaskEvent>(_onGetUserTasks);
    on<SetTasksListEvent>(_onSetTasksList);
    on<GetRemoteTasksEvent>(_onGetRemoteTasks);
  }
}

extension ShowAllBlocMappers on ShowAllBloc {
  void _onWatchTasks(WatchTasksEvent event, Emitter<ShowAllState> emit) {
    emit(state.copyWith(status: PageStatus.loading));
    watchTasksUseCase(NoParams()).listen((tasks) {
      setTasksList(tasks: tasks);
    });
    emit(
      state.copyWith(
        status: PageStatus.success,
        displayedStatus: PageStatus.success,
      ),
    );
  }

  void _onGetUserTasks(
    GetUserTaskEvent event,
    Emitter<ShowAllState> emit,
  ) async {
    emit(state.copyWith(userTasksStatus: PageStatus.loading));
    final result = await getUserTaskUseCase(event.userId);
    if (result.hasDataOnly) {
      emit(
        state.copyWith(
          userTasksStatus: PageStatus.success,
          userTasksList: result.data,
          displayedList:
              state.type == TasksType.all ? state.allTasksList : result.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          userTasksStatus: PageStatus.error,
          error: result.error.toString(),
        ),
      );
    }
  }

  void _onGetRemoteTasks(
    GetRemoteTasksEvent event,
    Emitter<ShowAllState> emit,
  ) async {
    if (event.loading ?? false) {
      emit(state.copyWith(remoteStatus: PageStatus.loading));
    }
    final result = await getRemoteTaskUseCase(NoParams());
    if (result.hasDataOnly) {
      emit(
        state.copyWith(
          remoteStatus: PageStatus.success,
          remoteTasksList: result.data?.reversed.toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          remoteStatus: PageStatus.error,
          error: result.error.toString(),
        ),
      );
    }
  }

  void _onSetTasksList(SetTasksListEvent event, Emitter<ShowAllState> emit) {
    emit(
      state.copyWith(
        allTasksList: event.tasks,
        displayedList:
            state.type == TasksType.all ? event.tasks : state.userTasksList,
      ),
    );
  }

  void _onSwitchDisplayedTasks(
    SwitchListEvent event,
    Emitter<ShowAllState> emit,
  ) {
    final type = state.type.toggle();
    emit(
      state.copyWith(
        type: type,
        displayedList: checkCurrentlyDisplayedTasks(type),
        displayedStatus:
            state.type == TasksType.all ? state.status : state.userTasksStatus,
      ),
    );
  }
}

extension ShowAllBlocActions on ShowAllBloc {
  void setTasksList({required List<TaskModel> tasks}) {
    add(SetTasksListEvent(tasks: tasks));
  }

  void watchTasks() {
    add(WatchTasksEvent());
  }

  void getUserTasks(int id) {
    add(GetUserTaskEvent(userId: id));
  }

  void switchListType() {
    add(SwitchListEvent());
  }

  void getRemoteTasks({bool? loading = true}) {
    add(GetRemoteTasksEvent(loading: loading));
  }
}

extension ShowAllBlocHelpers on ShowAllBloc {
  List<TaskModel> checkCurrentlyDisplayedTasks(TasksType current) {
    return current == TasksType.all ? state.allTasksList : state.userTasksList;
  }
}
