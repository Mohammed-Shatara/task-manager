import 'package:dartz/dartz.dart';
import 'package:task_manager/core/datasource/remote_data_source.dart';

import '../../../../core/error/base_error.dart';
import '../../../models/task_model.dart';
import '../../../requests/task_requests.dart';

abstract class TasksRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, int?>> createTask(TaskRequest task);
  Future<Either<BaseError, List<TaskModel>>> getAllTasks();
}
