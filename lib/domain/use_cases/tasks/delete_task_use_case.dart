import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../repositories/tasks_repository.dart';

class DeleteTaskUseCase extends UseCase<Future<Result<BaseError, bool>>, int> {
  final TasksRepository tasksRepository;

  DeleteTaskUseCase({required this.tasksRepository});
  @override
  Future<Result<BaseError, bool>> call(int params) {
    return tasksRepository.deleteTask(params);
  }
}
