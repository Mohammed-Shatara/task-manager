part of 'create_task_cubit.dart';

enum TaskStatus { pending, done, blocked }

class CreateTaskState extends Equatable {
  const CreateTaskState({
    this.pageStatus = PageStatus.init,
    this.error = '',
    this.name = '',
    this.description,
    this.userId,
    this.taskStatus = TaskStatus.pending,
    this.dueDate,
    this.valid,
  });

  final PageStatus pageStatus;
  final String name;
  final String? description;
  final TaskStatus taskStatus;
  final int? userId;
  final DateTime? dueDate;
  final String error;
  final bool? valid;

  CreateTaskState copyWith({
    PageStatus? pageStatus,
    String? error,
    String? name,
    String? description,
    int? userId,
    TaskStatus? taskStatus,
    DateTime? dueDate,
    bool? valid,
  }) {
    return CreateTaskState(
      pageStatus: pageStatus ?? this.pageStatus,
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
  List<Object?> get props => [pageStatus, error, valid, name, description, taskStatus, dueDate,userId];
}

extension TaskStatusExtension on TaskStatus {
  static TaskStatus fromName(String name) {
    return TaskStatus.values.firstWhere(
          (e) => e.name == name,
      orElse: () => TaskStatus.pending, // fallback if no match
    );
  }
}