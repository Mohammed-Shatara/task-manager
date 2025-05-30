import 'package:task_manager/domain/repositories/tasks_repository.dart';

import '../../core/error/base_error.dart';
import '../../core/result/result.dart';
import '../data_sources/tasks/tasks_data_source.dart';
import '../models/task_model.dart';
import '../requests/task_requests.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksDataSource tasksDataSource;

  TasksRepositoryImpl({required this.tasksDataSource});

  @override
  Future<Result<BaseError, TaskModel>> getTaskById(int id) async {
    final result = await tasksDataSource.getTaskById(id);
    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Future<Result<BaseError, int>> createTask(TaskRequest task) async {
    final result = await tasksDataSource.createTask(task);
    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Future<Result<BaseError, bool>> updateTask(UpdateTaskRequest task) async {
    final result = await tasksDataSource.updateTask(task);
    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Future<Result<BaseError, bool>> deleteTask(int id) async {
    final result = await tasksDataSource.deleteTask(id);
    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Future<Result<BaseError, List<TaskModel>>> getAllTasks() async {
    final result = await tasksDataSource.getAllTasks();

    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Future<Result<BaseError, List<TaskModel>>> getTasksByUserId(
    int userId,
  ) async {
    final result = await tasksDataSource.getTasksByUserId(userId);

    return result.fold(
      (error) => Result(error: error),
      (data) => Result(data: data),
    );
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    return tasksDataSource.watchTasks();
  }

  @override
  Stream<List<TaskWithUserModel>> watchTasksWithUsers() {
    return tasksDataSource.watchTasksWithUsers();
  }
}
