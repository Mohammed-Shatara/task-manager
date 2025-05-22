import 'package:task_manager/core/param/no_param.dart';

import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../../data/models/task_model.dart';
import '../../repositories/tasks_repository.dart';

class GetRemoteTaskUseCase
    extends UseCase<Future<Result<BaseError, List<TaskModel>>>, NoParams> {
  final TasksRepository tasksRepository;

  GetRemoteTaskUseCase({required this.tasksRepository});

  @override
  Future<Result<BaseError, List<TaskModel>>> call(NoParams params) async {
    return tasksRepository.getRemoteTasks();
  }
}
