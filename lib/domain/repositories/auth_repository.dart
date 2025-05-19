import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/repository/repository.dart';
import 'package:task_manager/core/result/result.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository extends Repository {
  Future<Result<BaseError, UserModel>> login(String email, String password);
  Future<Result<BaseError, UserModel>> createUser(UserModel userModel);
}
