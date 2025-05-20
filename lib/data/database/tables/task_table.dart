import 'package:drift/drift.dart';
import 'user_table.dart';

@UseRowClass(Task, generateInsertable: true)
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get dueDate => dateTime()();
}

class Task {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final String status;
  final DateTime dueDate;

  Task({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.status,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as int,
    userId: json['userId'] as int,
    name: json['name'] as String,
    description: json['description'] as String?,
    status: json['status'] as String,
    dueDate: DateTime.parse(json['dueDate'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'name': name,
    'description': description,
    'status': status,
    'dueDate': dueDate.toIso8601String(),
  };
}

class TaskWithUser {
  final Task task;
  final User user;

  TaskWithUser({required this.task, required this.user});
}
