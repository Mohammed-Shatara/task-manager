import 'package:task_manager/core/error/base_error.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';

import '../../../../core/result/result.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/validators/base_validator.dart';
import '../login_use_case.dart';

class LoginValidatorUseCase
    extends UseCase<Result<BaseError, bool>, LoginParams> {
  final RequiredValidator requiredValidator;
  final EmailValidator emailValidator;
  final PasswordValidator passwordValidator;

  LoginValidatorUseCase({
    required this.requiredValidator,
    required this.emailValidator,
    required this.passwordValidator,
  });

  @override
  Result<BaseError, bool> call(LoginParams params) {
    final emailError = BaseValidator.validateValue(params.email, [
      requiredValidator,
      emailValidator,
    ], true);
    if (emailError != null) {
      return Result(error: CustomError(message: emailError));
    }

    final passwordError = BaseValidator.validateValue(params.password, [
      requiredValidator,
      passwordValidator,
    ], true);
    if (passwordError != null) {
      return Result(error: CustomError(message: passwordError));
    }

    return Result(data: true);
  }
}
