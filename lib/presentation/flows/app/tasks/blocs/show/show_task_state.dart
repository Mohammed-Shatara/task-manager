part of 'show_task_cubit.dart';

class ShowState extends Equatable {
  const ShowState({
    this.status = PageStatus.init,
    this.taskModel,
    this.error = '',
  });

  final PageStatus status;
  final TaskModel? taskModel;
  final String error;

  ShowState copyWith({
    PageStatus? status,
    TaskModel? taskModel,
    String? error,
  }) {
    return ShowState(
      status: status ?? this.status,
      taskModel: taskModel ?? this.taskModel,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, taskModel, error];
}
