part of 'show_all_bloc.dart';

enum TasksType { all, user }

extension TasksTypeExtension on TasksType {
  TasksType toggle() {
    return this == TasksType.all ? TasksType.user : TasksType.all;
  }
}

class ShowAllState extends Equatable {
  const ShowAllState({
    this.status = PageStatus.init,
    this.userTasksStatus = PageStatus.init,
    this.displayedStatus = PageStatus.init,
    this.remoteStatus = PageStatus.init,
    this.type = TasksType.all,
    this.displayedList = const [],
    this.userTasksList = const [],
    this.allTasksList = const [],
    this.remoteTasksList = const [],
    this.error = '',
    this.remoteError = '',
  });

  final PageStatus status;
  final PageStatus userTasksStatus;
  final PageStatus displayedStatus;
  final PageStatus remoteStatus;
  final TasksType type;
  final List<TaskModel> displayedList;
  final List<TaskModel> userTasksList;
  final List<TaskModel> allTasksList;
  final List<TaskModel> remoteTasksList;
  final String error;
  final String remoteError;

  ShowAllState copyWith({
    PageStatus? status,
    PageStatus? userTasksStatus,
    PageStatus? displayedStatus,
    PageStatus? remoteStatus,
    TasksType? type,
    List<TaskModel>? displayedList,
    List<TaskModel>? userTasksList,
    List<TaskModel>? allTasksList,
    List<TaskModel>? remoteTasksList,
    String? error,
    String? remoteError,
  }) {
    return ShowAllState(
      status: status ?? this.status,
      userTasksStatus: userTasksStatus ?? this.userTasksStatus,
      displayedStatus: displayedStatus ?? this.displayedStatus,
      remoteStatus: remoteStatus ?? this.remoteStatus,
      type: type ?? this.type,
      displayedList: displayedList ?? this.displayedList,
      userTasksList: userTasksList ?? this.userTasksList,
      allTasksList: allTasksList ?? this.allTasksList,
      remoteTasksList: remoteTasksList ?? this.remoteTasksList,
      error: error ?? this.error,
      remoteError: remoteError ?? this.remoteError,
    );
  }

  @override
  List<Object?> get props => [
    status,
    userTasksStatus,
    displayedStatus,
    remoteStatus,
    type,
    displayedList,
    userTasksList,
    allTasksList,
    remoteTasksList,
    error,
    remoteError,
  ];
}
