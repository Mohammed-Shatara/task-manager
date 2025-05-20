import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TaskRequest {
  final int userId;
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;

  TaskRequest({
    required this.userId,
    required this.name,
    this.description,
    required this.status,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'description': description,
    'status': status,
    'dueDate': dueDate.toIso8601String(),
  };

  TasksCompanion toCompanion() => TasksCompanion(
    userId: Value(userId),
    name: Value(name),
    description: Value(description),
    status: Value(status),
    dueDate: Value(dueDate),
  );
}

class UpdateTaskRequest {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;

  UpdateTaskRequest({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.status,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'description': description,
    'status': status,
    'dueDate': dueDate.toIso8601String(),
  };

  TasksCompanion toCompanion() => TasksCompanion(
    id: Value(id),
    userId: Value(userId),
    name: Value(name),
    description: Value(description),
    status: Value(status),
    dueDate: Value(dueDate),
  );
}
