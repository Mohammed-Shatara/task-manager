import 'package:task_manager/core/repository/repository.dart';
import 'package:task_manager/core/result/result.dart';

import '../../core/error/base_error.dart';
import '../../data/models/task_model.dart';
import '../../data/requests/task_requests.dart';

abstract class TasksRepository extends Repository {
  Future<Result<BaseError, int>> createTask(TaskRequest task);
  Future<Result<BaseError, List<TaskModel>>> getTasksByUserId(int userId);
  Future<Result<BaseError, List<TaskModel>>> getAllTasks();
  Future<Result<BaseError, List<TaskModel>>> getRemoteTasks();
  Stream<List<TaskWithUserModel>> watchTasksWithUsers();
  Stream<List<TaskModel>> watchTasks();
  Future<Result<BaseError, TaskModel>> getTaskById(int id);

  Future<Result<BaseError, bool>> updateTask(UpdateTaskRequest task);
  Future<Result<BaseError, bool>> deleteTask(int id);
}
