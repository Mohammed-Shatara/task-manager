import '../../../../core/error/base_error.dart';
import '../../../../core/error/custom_error.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/validators/base_validator.dart';
import '../../../../core/validators/password_validators.dart';
import '../../../../core/validators/required_validator.dart';
import '../create_task_use_case.dart';

class TaskValidationUseCase extends UseCase<Result<BaseError, bool>, TaskParams> {
  final RequiredValidator requiredValidator;
  final MinimumValidator minimumValidator;
  final DateValidator dateValidator;

  TaskValidationUseCase({required this.requiredValidator, required this.minimumValidator,required this.dateValidator,});

  @override
  Result<BaseError, bool> call(TaskParams params) {
    final nameError = BaseValidator.validateValue(params.name, [
      requiredValidator,
      minimumValidator,
    ], true);

    final statusError = BaseValidator.validateValue(params.status, [requiredValidator], true);

    final isDueDateValid = dateValidator.validateFunction(params.dueDate);
    final dueDateError = isDueDateValid ? null : dateValidator.getValidateMessage();

    if (nameError != null) {
      return Result(error: CustomError(message: nameError));
    }

    if (statusError != null) {
      return Result(error: CustomError(message: statusError));
    }

    if (dueDateError != null) {
      return Result(error: CustomError(message: dueDateError));
    }

    return Result(data: true);
  }
}
