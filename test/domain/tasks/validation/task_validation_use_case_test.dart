import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

void main() {
  late RequiredValidator requiredValidator;
  late MinimumValidator minimumValidator;
  late DateValidator dateValidator;
  late TaskValidationUseCase useCase;

  setUp(() {
    requiredValidator = RequiredValidator();
    minimumValidator = MinimumValidator(minLength: 3);
    dateValidator = DateValidator();

    useCase = TaskValidationUseCase(
      requiredValidator: requiredValidator,
      minimumValidator: minimumValidator,
      dateValidator: dateValidator,
    );
  });

  group('TaskValidationUseCase', () {
    test('returns Result(data: true) for valid input', () {
      final result = useCase(TaskParams(
        name: 'Valid Task',
        status: 'pending',
        userId: 1,
        dueDate: DateTime.now().add(Duration(days: 1)),
      ));

      expect(result.hasDataOnly, true);
      expect(result.data, true);
    });

    test('returns error if name is empty', () {
      final result = useCase(TaskParams(
        name: '',
        status: 'pending',
        userId: 3,

        dueDate: DateTime.now().add(Duration(days: 1)),
      ));

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Required Input');
    });

    test('returns error if name is too short', () {
      final result = useCase(TaskParams(
        name: 'Hi',
        status: 'pending',
        userId: 4,
        dueDate: DateTime.now().add(Duration(days: 1)),
      ));

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'minimum length should be 3');
    });

    test('returns error if status is empty', () {
      final result = useCase(TaskParams(
        name: 'Valid Task',
        status: '',
        userId: 6,
        dueDate: DateTime.now().add(Duration(days: 1)),
      ));

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Required Input');
    });

    test('returns error if dueDate is in the past', () {
      final result = useCase(TaskParams(
        name: 'Valid Task',
        status: 'pending',
        userId: 7,
        dueDate: DateTime.now().subtract(Duration(days: 1)),
      ));

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Date must be in the future');
    });
  });
}
