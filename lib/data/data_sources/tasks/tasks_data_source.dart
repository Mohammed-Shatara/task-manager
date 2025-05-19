import 'package:task_manager/core/error/base_error.dart';

import 'package:dartz/dartz.dart';

import '../../models/task_model.dart';

abstract class TasksDataSource {
  Future<Either<BaseError, int>> createTask(TaskModel task);
  Future<Either<BaseError, List<TaskModel>>> getTasksByUserId(int userId);
  Future<Either<BaseError, List<TaskModel>>> getAllTasks();
  Stream<List<TaskModel>> watchTasksByUserId(int userId);
  Future<Either<BaseError, TaskModel>> getTaskById(int id);

  Future<Either<BaseError, Unit>> updateTask(TaskModel task);
  Future<Either<BaseError, Unit>> deleteTask(int id);
}
