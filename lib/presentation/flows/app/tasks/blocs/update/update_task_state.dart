part of 'update_task_cubit.dart';

class UpdateTaskState extends Equatable {
  const UpdateTaskState({
    this.updateStatus = PageStatus.init,
    this.getTaskStatus = PageStatus.init,
    this.error = '',
    this.name = '',
    this.description,
    this.userId,
    this.taskStatus = TaskStatus.pending,
    this.dueDate,
    this.valid,
  });

  final PageStatus updateStatus;
  final PageStatus getTaskStatus;


  final String name;
  final String? description;
  final TaskStatus taskStatus;
  final int? userId;
  final DateTime? dueDate;
  final String error;
  final bool? valid;

  UpdateTaskState copyWith({
    PageStatus? updateStatus,
    PageStatus? getTaskStatus,
    String? error,
    String? name,
    String? description,
    int? userId,
    TaskStatus? taskStatus,
    DateTime? dueDate,
    bool? valid,
  }) {
    return UpdateTaskState(
      updateStatus: updateStatus ?? this.updateStatus,
      getTaskStatus: getTaskStatus ?? this.getTaskStatus,
      error: error ?? this.error,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      taskStatus: taskStatus ?? this.taskStatus,
      dueDate: dueDate ?? this.dueDate,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object?> get props => [updateStatus,getTaskStatus, error, valid, name, description, taskStatus, dueDate,userId];
}