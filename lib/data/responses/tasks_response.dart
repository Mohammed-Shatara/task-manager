import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../core/response/api_response.dart';

class GetTaskResponse extends ApiResponse<List<TaskModel>?> {
  GetTaskResponse(String msg, bool hasError, List<TaskModel>? result)
    : super(msg, hasError, result);

  factory GetTaskResponse.fromJson(Response response) {
    String message = '';
    bool isSuccess = false;

    isSuccess = response.statusCode == 200;
    List<TaskModel>? model;

    if (isSuccess) {
      final decoded =
          response.data is String ? json.decode(response.data) : response.data;
      model = (decoded as List).map((e) => TaskModel.fromJson(e)).toList();
    } else {
      message = response.data["errCode"];
    }

    return GetTaskResponse(message, !isSuccess, model);
  }
}

class CreateTaskResponse extends ApiResponse<int?> {
  CreateTaskResponse(String msg, bool hasError, int? result)
    : super(msg, hasError, result);

  factory CreateTaskResponse.fromJson(Response response) {
    String message = '';
    bool isSuccess = false;

    isSuccess = response.statusCode == 201;
    int? model;

    if (isSuccess) {
      model = 1;
    } else {
      message = response.data["errCode"];
    }

    return CreateTaskResponse(message, !isSuccess, model);
  }
}
