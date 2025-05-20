import 'package:task_manager/data/requests/task_requests.dart';
import 'package:task_manager/domain/repositories/tasks_repository.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

import '../../../core/error/base_error.dart';
import '../../../core/param/base_param.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';

class CreateTaskUseCase
    extends UseCase<Future<Result<BaseError, int>>, TaskParams> {
  final TasksRepository tasksRepository;
  final TaskValidationUseCase taskValidationUseCase;

  CreateTaskUseCase({
    required this.tasksRepository,
    required this.taskValidationUseCase,
  });

  @override
  Future<Result<BaseError, int>> call(TaskParams params) async {
    final validationResult = taskValidationUseCase(params);
    if (validationResult.hasErrorOnly) {
      return Result(error: validationResult.error!);
    }
    return tasksRepository.createTask(
      TaskRequest(
        userId: params.userId,
        name: params.name,
        description: params.description,
        status: params.status,
        dueDate: params.dueDate,
      ),
    );
  }
}

class TaskParams extends BaseParams {
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;
  final int userId;

  TaskParams({
    required this.name,
    this.description,
    required this.userId,
    required this.status,
    required this.dueDate,
  });
}

class UpdateTaskParams extends BaseParams {
  final int id;
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;
  final int userId;

  UpdateTaskParams({
    required this.id,
    required this.name,
    this.description,
    required this.userId,
    required this.status,
    required this.dueDate,
  });
}
