import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/data/data_sources/tasks/tasks_data_source.dart';

import 'package:dartz/dartz.dart';

import '../../database/dao/task_dao.dart';
import '../../models/task_model.dart';
import '../../requests/task_requests.dart';

class TasksDataSourceImpl extends TasksDataSource {
  final TaskDao taskDao;

  TasksDataSourceImpl(this.taskDao);

  @override
  Future<Either<BaseError, int>> createTask(TaskRequest task) async {
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
  Future<Either<BaseError, TaskModel>> getTaskById(int id) async {
    try {
      final task = await taskDao.getTaskById(id);
      if (task == null) {
        return Left(CustomError(message: 'Task not found'));
      }
      return Right(TaskModel.fromTable(task));
    } catch (e) {
      return Left(CustomError(message: 'Unexpected error: $e'));
    }
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    return taskDao.watchAllTasks().map(
      (taskRows) => taskRows.map((task) => TaskModel.fromTable(task)).toList(),
    );
  }

  @override
  Stream<List<TaskWithUserModel>> watchTasksWithUsers() {
    return taskDao.watchTasksWithUsers().map(
      (tasksWithUsersRow) =>
          tasksWithUsersRow
              .map((taskWithUser) => TaskWithUserModel.fromTable(taskWithUser))
              .toList(),
    );
  }

  @override
  Future<Either<BaseError, bool>> updateTask(UpdateTaskRequest task) async {
    try {
      await taskDao.updateTask(task.toCompanion());
      return right(true);
    } catch (e) {
      return left(
        CustomError(message: 'Failed to update task: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<BaseError, bool>> deleteTask(int id) async {
    try {
      await taskDao.deleteTask(id);
      return right(true);
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
