part of 'create_task_cubit.dart';

enum TaskStatus { pending, done, blocked }

class CreateTaskState extends Equatable {
  const CreateTaskState({
    this.pageStatus = PageStatus.init,
    this.error = '',
    this.name = '',
    this.description,
    this.taskStatus = TaskStatus.pending,
    this.dueDate,
    this.valid,
  });

  final PageStatus pageStatus;
  final String name;
  final String? description;
  final TaskStatus taskStatus;
  final DateTime? dueDate;
  final String error;
  final bool? valid;

  CreateTaskState copyWith({
    PageStatus? pageStatus,
    String? error,
    String? name,
    String? description,
    TaskStatus? taskStatus,
    DateTime? dueDate,
    bool? valid,
  }) {
    return CreateTaskState(
      pageStatus: pageStatus ?? this.pageStatus,
      error: error ?? this.error,
      name: name ?? this.name,
      description: description ?? this.description,
      taskStatus: taskStatus ?? this.taskStatus,
      dueDate: dueDate ?? this.dueDate,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object?> get props => [
    pageStatus,
    error,
    valid,
    name,
    description,
    taskStatus,
    dueDate,
  ];
}

extension TaskStatusExtension on TaskStatus {
  static TaskStatus fromName(String name) {
    return TaskStatus.values.firstWhere(
      (e) => e.name == name,
      orElse: () => TaskStatus.pending, // fallback if no match
    );
  }

  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.blocked:
        return 'Blocked';
    }
  }

  Color color(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (this) {
      case TaskStatus.done:
        return scheme.secondary;
      case TaskStatus.pending:
        return scheme.tertiary;
      case TaskStatus.blocked:
        return scheme.error;
    }
  }

  Color bgColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (this) {
      case TaskStatus.done:
        return scheme.secondaryContainer.withValues(alpha: 0.5);
      case TaskStatus.pending:
        return scheme.tertiaryContainer.withValues(alpha: 0.5);
      case TaskStatus.blocked:
        return scheme.errorContainer.withValues(alpha: 0.5);
    }
  }
}
