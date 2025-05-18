import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/task_table.dart';

class TaskModel {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;

  TaskModel({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
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
    id: Value(id),
    userId: Value(userId),
    name: Value(name),
    description: Value(description),
    status: Value(status),
    dueDate: Value(dueDate),
  );
}
