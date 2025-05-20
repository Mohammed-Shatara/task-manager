import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/result/result.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth/auth_data_source.dart';
import '../models/user_model.dart';
import '../requests/user_request.dart';

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
  Future<Result<BaseError, UserModel>> createUser(
    UserRequest userRequest,
  ) async {
    final creationResult = await authDataSource.createUser(userRequest);

    return creationResult.fold((failure) => Result(error: failure), (_) async {
      final loginResult = await authDataSource.login(
        userRequest.email,
        userRequest.password,
      );
      return loginResult.fold(
        (loginFailure) => Result(error: loginFailure),
        (user) => Result(data: user),
      );
    });
  }

  @override
  Future<Result<BaseError, UserModel>> getUserById(int id) async {
    final result = await authDataSource.getUserById(id);
    return executeWithoutConvert(remoteResult: result);
  }
}
