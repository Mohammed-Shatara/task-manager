import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/base_error.dart';

import '../../models/user_model.dart';

abstract class AuthDataSource {
  Future<Either<BaseError, UserModel>> login(String email, String password);
  Future<Either<BaseError, int>> createUser(UserModel userModel);
}
