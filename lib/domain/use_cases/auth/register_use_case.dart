import 'package:task_manager/data/requests/user_request.dart';
import 'package:task_manager/domain/use_cases/auth/validations/register_validator_use_case.dart';

import '../../../core/error/base_error.dart';
import '../../../core/param/base_param.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';
import '../../../data/models/user_model.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase
    extends UseCase<Future<Result<BaseError, UserModel>>, RegisterParams> {
  final RegisterValidatorUseCase registerValidatorUseCase;
  final AuthRepository authRepository;

  RegisterUseCase({
    required this.registerValidatorUseCase,
    required this.authRepository,
  });

  @override
  Future<Result<BaseError, UserModel>> call(RegisterParams params) async {
    final validationResult = registerValidatorUseCase(params);

    if (validationResult.hasErrorOnly) {
      return Result(error: validationResult.error!);
    }

    return authRepository.createUser(
      UserRequest(
        fullname: params.fullName,
        email: params.email,
        password: params.password,
      ),
    );
  }
}

class RegisterParams extends BaseParams {
  final String fullName;
  final String email;
  final String password;

  RegisterParams({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
