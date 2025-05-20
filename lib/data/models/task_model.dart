import 'package:drift/drift.dart';
import 'package:task_manager/data/models/user_model.dart';

import '../database/app_database.dart';
import '../database/tables/task_table.dart';

class TaskModel {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final String? userFullName;
  final String status;
  final DateTime dueDate;

  TaskModel({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.userFullName,
    required this.status,
    required this.dueDate,
  });

  factory TaskModel.fromTable(Task task) => TaskModel(
    id: task.id,
    userId: task.userId,
    name: task.name,
    description: task.description,
    status: task.status,
    dueDate: task.dueDate,
  );

  Task toTableData() => Task(
    id: id,
    userId: userId,
    name: name,
    description: description,
    status: status,
    dueDate: dueDate,
  );

  TaskModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    String? userFullName,
    String? status,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      name: name ?? this.name,
      description: description ?? this.description,
      userFullName: userFullName ?? this.userFullName,
    );
  }

  @override
  String toString() {
    return '$id, $name, $description';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'name': name,
    'description': description,
    'status': status,
    'dueDate': dueDate.toIso8601String(),
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    userId: json['userId'],
    name: json['name'],
    description: json['description'],
    status: json['status'],
    dueDate: DateTime.parse(json['dueDate']),
  );

  TasksCompanion toCompanion() => TasksCompanion(
    userId: Value(userId),
    name: Value(name),
    description: Value(description),
    status: Value(status),
    dueDate: Value(dueDate),
  );
}

class TaskWithUserModel {
  final TaskModel task;
  final UserModel user;

  TaskWithUserModel({required this.task, required this.user});

  factory TaskWithUserModel.fromTable(TaskWithUser taskWithUser) =>
      TaskWithUserModel(
        task: TaskModel.fromTable(taskWithUser.task),
        user: UserModel.fromTable(taskWithUser.user),
      );
}
