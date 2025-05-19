import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/param/base_param.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/repositories/auth_repository.dart';
import 'package:task_manager/domain/use_cases/auth/validations/login_validator_use_case.dart';

import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';

class LoginUseCase
    extends UseCase<Future<Result<BaseError, UserModel>>, LoginParams> {
  final LoginValidatorUseCase loginValidatorUseCase;
  final AuthRepository authRepository;

  LoginUseCase({
    required this.loginValidatorUseCase,
    required this.authRepository,
  });

  @override
  Future<Result<BaseError, UserModel>> call(LoginParams params) async {
    final validationResult = loginValidatorUseCase(params);

    if (validationResult.hasErrorOnly) {
      return Result(error: validationResult.error!);
    }

    return authRepository.login(params.email, params.password);
  }
}

class LoginParams extends BaseParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
