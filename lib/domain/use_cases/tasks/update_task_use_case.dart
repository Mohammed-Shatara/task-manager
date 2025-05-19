import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../../data/requests/task_requests.dart';
import '../../repositories/tasks_repository.dart';
import 'create_task_use_case.dart';

class UpdateTaskUseCase extends UseCase<Future<Result<BaseError, bool>>, TaskParams> {
  final TasksRepository tasksRepository;
  final TaskValidationUseCase taskValidationUseCase;

  UpdateTaskUseCase({required this.tasksRepository, required this.taskValidationUseCase});

  @override
  Future<Result<BaseError, bool>> call(TaskParams params) async {
    final validationResult = taskValidationUseCase(params);
    if (validationResult.hasErrorOnly) {
      return Result(error: validationResult.error!);
    }
    return tasksRepository.updateTask(
      TaskRequest(
        userId: params.userId,
        name: params.name,
        status: params.status,
        dueDate: params.dueDate,
      ),
    );
  }
}
