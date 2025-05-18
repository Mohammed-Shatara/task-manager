import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/user_table.dart';

class UserModel {
  final int id;
  final String fullname;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory UserModel.fromTable(User user) => UserModel(
    id: user.id,
    fullname: user.fullname,
    email: user.email,
    password: user.password,
  );

  User toTableData() =>
      User(id: id, fullname: fullname, email: email, password: password);

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullname': fullname,
    'email': email,
    'password': password,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    fullname: json['fullname'],
    email: json['email'],
    password: json['password'],
  );

  UsersCompanion toCompanion() => UsersCompanion(
    id: Value(id),
    fullname: Value(fullname),
    email: Value(email),
    password: Value(password),
  );
}
