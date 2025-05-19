import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<int> createUser(UsersCompanion user) => into(users).insert(user);

  Future<User?> getUserByEmail(String email) =>
      (select(users)..where((u) => u.email.equals(email))).getSingleOrNull();

  Future<List<User>> getAllUsers() => select(users).get();

  Future<User?> getUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future updateUser(UsersCompanion user) => update(users).replace(user);

  Future deleteUser(int id) => (delete(users)..where((u) => u.id.equals(id))).go();

  Future<User?> login(String email, String password) async {
    return (select(users)
      ..where((u) => u.email.equals(email) & u.password.equals(password))).getSingleOrNull();
  }
}
