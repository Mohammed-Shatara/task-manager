import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/result/result.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth/auth_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Result<BaseError, UserModel>> login(
    String email,
    String password,
  ) async {
    final result = await authDataSource.login(email, password);
    return executeWithoutConvert(remoteResult: result);
  }

  @override
  Future<Result<BaseError, UserModel>> createUser(UserModel userModel) async {
    final creationResult = await authDataSource.createUser(userModel);

    return creationResult.fold((failure) => Result(error: failure), (_) async {
      final loginResult = await authDataSource.login(
        userModel.email,
        userModel.password,
      );
      return loginResult.fold(
        (loginFailure) => Result(error: loginFailure),
        (user) => Result(data: user),
      );
    });
  }
}
