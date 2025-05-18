import 'package:task_manager/domain/use_cases/auth/register_use_case.dart';

import '../../../../core/error/base_error.dart';
import '../../../../core/error/custom_error.dart';
import '../../../../core/param/base_param.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/validators/base_validator.dart';
import '../../../../core/validators/email_validator.dart';
import '../../../../core/validators/password_validators.dart';
import '../../../../core/validators/required_validator.dart';

class RegisterValidatorUseCase
    extends UseCase<Result<BaseError, bool>, RegisterParams> {
  final RequiredValidator requiredValidator;
  final EmailValidator emailValidator;
  final PasswordValidator passwordValidator;
  final MinimumValidator minimumValidator;

  RegisterValidatorUseCase({
    required this.requiredValidator,
    required this.emailValidator,
    required this.passwordValidator,
    required this.minimumValidator,
  });

  @override
  Result<BaseError, bool> call(RegisterParams params) {
    final minimumError = BaseValidator.validateValue(params.fullName, [
      requiredValidator,
      minimumValidator,
    ], true);

    if (minimumError != null)
      return Result(error: CustomError(message: minimumError));

    final emailError = BaseValidator.validateValue(params.email, [
      requiredValidator,
      emailValidator,
    ], true);
    if (emailError != null)
      return Result(error: CustomError(message: emailError));

    final passwordError = BaseValidator.validateValue(params.password, [
      requiredValidator,
      passwordValidator,
    ], true);
    if (passwordError != null)
      return Result(error: CustomError(message: passwordError));

    return Result(data: true);
  }
}
