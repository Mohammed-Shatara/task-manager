import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/resources/apis.dart';
import 'package:task_manager/data/data_sources/tasks/remote/tasks_remote_data_source.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/requests/task_requests.dart';

import '../../../../core/datasource/api_call_params.dart';
import '../../../../core/enums/api/HttpMethod.dart';
import '../../../responses/tasks_response.dart';

class TasksRemoteDataSourceImpl extends TasksRemoteDataSource {
  @override
  Future<Either<BaseError, int?>> createTask(TaskRequest task) {
    return request<int?, CreateTaskResponse>(
      ApiCallParams<CreateTaskResponse>(
        responseStr: "CreateTaskResponse",
        mapper: (json) => CreateTaskResponse.fromJson(json),
        data: task.toJson(),
        method: HttpMethod.post,
        url: ApiUrls.tasks,
      ),
    );
  }

  @override
  Future<Either<BaseError, List<TaskModel>>> getAllTasks() {
    return request<List<TaskModel>, GetTaskResponse>(
      ApiCallParams<GetTaskResponse>(
        responseStr: "GetTaskResponse",
        mapper: (json) => GetTaskResponse.fromJson(json),
        method: HttpMethod.get,
        url: ApiUrls.tasks,
      ),
    );
  }
}
