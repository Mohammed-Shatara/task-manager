import 'package:drift/drift.dart';

@UseRowClass(User, generateInsertable: true)
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullname => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
}

class User {
  final int id;
  final String fullname;
  final String email;
  final String password;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    fullname: json['fullname'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullname': fullname,
    'email': email,
    'password': password,
  };
}
