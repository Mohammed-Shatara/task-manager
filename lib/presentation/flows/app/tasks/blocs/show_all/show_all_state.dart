part of 'show_all_bloc.dart';

enum TasksType {all, user}

extension TasksTypeExtension on TasksType {
  TasksType toggle() {
    return this == TasksType.all ? TasksType.user : TasksType.all;
  }
}

class ShowAllState extends Equatable {
  const ShowAllState({
     this.status = PageStatus.init,
     this.type = TasksType.all,
     this.displayedList = const [],
     this.userTasksList  = const [],
     this.allTasksList  = const [],
     this.error = '',
  });


  final PageStatus status;
  final TasksType type;
  final List<TaskModel> displayedList;
  final List<TaskModel> userTasksList;
  final List<TaskModel> allTasksList;
  final String error;

  ShowAllState copyWith({
    PageStatus? status,
    TasksType? type,
    List<TaskModel>? displayedList,
    List<TaskModel>? userTasksList,
    List<TaskModel>? allTasksList,
    String? error,
  }) {
    return ShowAllState(
      status: status ?? this.status,
      type: type ?? this.type,
      displayedList: displayedList ?? this.displayedList,
      userTasksList: userTasksList ?? this.userTasksList,
      allTasksList: allTasksList ?? this.allTasksList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    type,
    displayedList,
    userTasksList,
    allTasksList,
    error,
  ];
}


