import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/param/no_param.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/domain/use_cases/tasks/get_user_tasks_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/watch_tasks_use_case.dart';

part 'show_all_event.dart';

part 'show_all_state.dart';

class ShowAllBloc extends Bloc<ShowAllEvent, ShowAllState> {
  final WatchTasksUseCase watchTasksUseCase;
  final GetUserTaskUseCase getUserTaskUseCase;

  ShowAllBloc({required this.watchTasksUseCase, required this.getUserTaskUseCase})
    : super(ShowAllState()) {
    on<SwitchListEvent>(_onSwitchDisplayedTasks);
    on<WatchTasksEvent>(_onWatchTasks);
    on<GetUserTaskEvent>(_onGetUserTasks);
    on<SetTasksListEvent>(_onSetTasksList);
    on<SwitchListEvent>(_onSwitchDisplayedTasks);
  }
}

extension ShowAllBlocMappers on ShowAllBloc {
  void _onWatchTasks(WatchTasksEvent event, Emitter<ShowAllState> emit) {
    emit(state.copyWith(status: PageStatus.loading));
    watchTasksUseCase(NoParams()).listen((tasks) {
      setTasksList(tasks: tasks);
    });
    emit(state.copyWith(status: PageStatus.success));
  }

  void _onGetUserTasks(GetUserTaskEvent event, Emitter<ShowAllState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    final result = await getUserTaskUseCase(event.userId);
    if (result.hasDataOnly) {
      emit(
        state.copyWith(
          status: PageStatus.success,
          userTasksList: result.data,
          displayedList: checkCurrentlyDisplayedTasks(state.type),
        ),
      );
    } else {
      emit(state.copyWith(status: PageStatus.error, error: result.error.toString()));
    }
  }

  void _onSetTasksList(SetTasksListEvent event, Emitter<ShowAllState> emit) {
    emit(
      state.copyWith(
        allTasksList: event.tasks,
        displayedList: checkCurrentlyDisplayedTasks(state.type),
      ),
    );
  }

  void _onSwitchDisplayedTasks(SwitchListEvent event, Emitter<ShowAllState> emit) {
    final type = state.type.toggle();

    emit(state.copyWith(type: type, displayedList: checkCurrentlyDisplayedTasks(type)));
  }
}

extension ShowAllBlocActions on ShowAllBloc {
  void setTasksList({required List<TaskModel> tasks}) {
    add(SetTasksListEvent(tasks: tasks));
  }
}

extension ShowAllBlocHelpers on ShowAllBloc {
  List<TaskModel> checkCurrentlyDisplayedTasks(TasksType current) {
    return current == TasksType.all ? state.allTasksList : state.userTasksList;
  }
}
