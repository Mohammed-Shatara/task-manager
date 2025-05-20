import 'package:task_manager/data/models/task_model.dart';

import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../repositories/tasks_repository.dart';

class GetSingleTaskUseCase
    extends UseCase<Future<Result<BaseError, TaskModel>>, int> {
  final TasksRepository tasksRepository;

  GetSingleTaskUseCase({required this.tasksRepository});

  @override
  Future<Result<BaseError, TaskModel>> call(int params) async {
    return tasksRepository.getTaskById(params);
  }
}
