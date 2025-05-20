import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/task_table.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  Future<int> createTask(TasksCompanion task) => into(tasks).insert(task);

  Future<List<Task>> getAllTasks() =>
      (select(tasks)..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])).get();

  Stream<List<Task>> watchAllTasks() =>
      (select(tasks)..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])).watch();

  Stream<List<TaskWithUser>> watchTasksWithUsers() {
    final query = select(
      tasks,
    ).join([innerJoin(users, users.id.equalsExp(tasks.userId))]);

    query.orderBy([
      OrderingTerm(expression: tasks.id, mode: OrderingMode.desc),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final task = row.readTable(tasks);
        final user = row.readTable(users);
        return TaskWithUser(task: task, user: user);
      }).toList();
    });
  }

  Future<List<Task>> getTasksForUser(int userId) =>
      (select(tasks)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
            ]))
          .get();

  Future<Task?> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> updateTask(TasksCompanion task) => update(tasks).replace(task);

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
