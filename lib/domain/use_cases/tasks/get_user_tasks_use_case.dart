import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../../data/models/task_model.dart';
import '../../repositories/tasks_repository.dart';

class GetUserTaskUseCase extends UseCase<Future<Result<BaseError, List<TaskModel>>>, int> {
  final TasksRepository tasksRepository;

  GetUserTaskUseCase({required this.tasksRepository});

  @override
  Future<Result<BaseError, List<TaskModel>>> call(int params) async {
    return tasksRepository.getTasksByUserId(params);
  }
}
