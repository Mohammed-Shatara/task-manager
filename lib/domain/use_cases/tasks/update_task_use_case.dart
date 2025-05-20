import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../../data/requests/task_requests.dart';
import '../../repositories/tasks_repository.dart';
import 'create_task_use_case.dart';

class UpdateTaskUseCase
    extends UseCase<Future<Result<BaseError, bool>>, UpdateTaskParams> {
  final TasksRepository tasksRepository;
  final UpdateTaskValidationUseCase updateTaskValidationUseCase;

  UpdateTaskUseCase({
    required this.tasksRepository,
    required this.updateTaskValidationUseCase,
  });

  @override
  Future<Result<BaseError, bool>> call(UpdateTaskParams params) async {
    final validationResult = updateTaskValidationUseCase(params);
    if (validationResult.hasErrorOnly) {
      return Result(error: validationResult.error!);
    }
    return tasksRepository.updateTask(
      UpdateTaskRequest(
        id: params.id,
        userId: params.userId,
        name: params.name,
        description: params.description,
        status: params.status,
        dueDate: params.dueDate,
      ),
    );
  }
}
