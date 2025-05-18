import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'tables/user_table.dart';
import 'tables/task_table.dart';
import 'dao/user_dao.dart';
import 'dao/task_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Tasks], daos: [UserDao, TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'app.sqlite');
    return NativeDatabase(File(path));
  });
}
