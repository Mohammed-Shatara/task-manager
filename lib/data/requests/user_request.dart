import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/user_table.dart';

class UserRequest {
  final String fullname;
  final String email;
  final String password;

  UserRequest({
    required this.fullname,
    required this.email,
    required this.password,
  });


  UsersCompanion toCompanion() => UsersCompanion(
    fullname: Value(fullname),
    email: Value(email),
    password: Value(password),
  );
}
