import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/data/data_sources/tasks/tasks_data_source.dart';

import 'package:dartz/dartz.dart';

import '../../database/dao/task_dao.dart';
import '../../models/task_model.dart';

class TasksDataSourceImpl extends TasksDataSource {
  final TaskDao taskDao;

  TasksDataSourceImpl(this.taskDao);

  @override
  Future<Either<BaseError, int>> createTask(TaskModel task) async {
    try {
      final id = await taskDao.createTask(task.toCompanion());
      return right(id);
    } catch (e) {
      return left(
        CustomError(message: 'Failed to create task: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<BaseError, List<TaskModel>>> getTasksByUserId(
    int userId,
  ) async {
    try {
      final tasks = await taskDao.getTasksForUser(userId);
      return right(tasks.map((t) => TaskModel.fromTable(t)).toList());
    } catch (e) {
      return left(
        CustomError(message: 'Failed to fetch tasks: ${e.toString()}'),
      );
    }
  }

  @override
  Stream<List<TaskModel>> watchTasksByUserId(int userId) {
    return taskDao.watchAllTasks().map(
      (taskRows) => taskRows.map((task) => TaskModel.fromTable(task)).toList(),
    );
  }

  @override
  Future<Either<BaseError, Unit>> updateTask(TaskModel task) async {
    try {
      await taskDao.updateTask(task.toCompanion());
      return right(unit);
    } catch (e) {
      return left(
        CustomError(message: 'Failed to update task: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<BaseError, Unit>> deleteTask(int id) async {
    try {
      await taskDao.deleteTask(id);
      return right(unit);
    } catch (e) {
      return left(
        CustomError(message: 'Failed to delete task: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<BaseError, List<TaskModel>>> getAllTasks() async {
    try {
      final tasks = await taskDao.getAllTasks();
      return right(tasks.map((t) => TaskModel.fromTable(t)).toList());
    } catch (e) {
      return left(
        CustomError(message: 'Failed to fetch tasks: ${e.toString()}'),
      );
    }
  }
}
