import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/error/custom_error.dart';

import '../../database/dao/user_dao.dart';
import '../../models/user_model.dart';
import 'auth_data_source.dart';

import 'package:dartz/dartz.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final UserDao userDao;

  AuthDataSourceImpl(this.userDao);

  @override
  Future<Either<BaseError, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await userDao.login(email, password);
      if (user == null) {
        return left(CustomError(message: 'Invalid email or password'));
      }
      return right(
        UserModel(
          id: user.id,
          fullname: user.fullname,
          email: user.email,
          password: user.password,
        ),
      );
    } catch (e) {
      return left(CustomError(message: 'Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<BaseError, int>> createUser(UserModel userModel) async {
    try {
      final id = await userDao.createUser(userModel.toCompanion());
      return right(id);
    } catch (e) {
      return left(
        CustomError(message: 'Failed to create user: ${e.toString()}'),
      );
    }
  }
}
