import 'package:task_manager/core/error/base_error.dart';

import 'package:dartz/dartz.dart';

import '../../models/task_model.dart';
import '../../requests/task_requests.dart';

abstract class TasksDataSource {
  Future<Either<BaseError, int>> createTask(TaskRequest task);
  Future<Either<BaseError, List<TaskModel>>> getTasksByUserId(int userId);
  Future<Either<BaseError, List<TaskModel>>> getAllTasks();
  Stream<List<TaskModel>> watchTasks();
  Stream<List<TaskWithUserModel>> watchTasksWithUsers();
  Future<Either<BaseError, TaskModel>> getTaskById(int id);

  Future<Either<BaseError, bool>> updateTask(UpdateTaskRequest task);
  Future<Either<BaseError, bool>> deleteTask(int id);
}
