import 'package:task_manager/core/param/no_param.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../../core/usecases/base_use_case.dart';
import '../../repositories/tasks_repository.dart';

class WatchTasksUseCase extends UseCase<Stream<List<TaskModel>>, NoParams> {
  final TasksRepository tasksRepository;

  WatchTasksUseCase({required this.tasksRepository});
  @override
  Stream<List<TaskModel>> call(NoParams params) {
    return tasksRepository.watchTasks();
  }
}
