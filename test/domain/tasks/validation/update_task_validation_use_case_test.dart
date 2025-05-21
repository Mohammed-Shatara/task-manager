import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

void main() {
  late IdRequiredValidator idRequiredValidator;
  late RequiredValidator requiredValidator;
  late MinimumValidator minimumValidator;
  late DateValidator dateValidator;
  late UpdateTaskValidationUseCase useCase;

  setUp(() {
    idRequiredValidator = IdRequiredValidator();
    requiredValidator = RequiredValidator();
    minimumValidator = MinimumValidator(minLength: 3);
    dateValidator = DateValidator();

    useCase = UpdateTaskValidationUseCase(
      idRequiredValidator: idRequiredValidator,
      requiredValidator: requiredValidator,
      minimumValidator: minimumValidator,
      dateValidator: dateValidator,
    );
  });

  group('UpdateTaskValidationUseCase', () {
    test('returns success for valid input', () {
      final result = useCase(
        UpdateTaskParams(
          id: 1,
          name: 'Task Updated',
          description: 'Task description',
          status: 'blocked',
          userId: 4,

          dueDate: DateTime.now().add(Duration(days: 2)),
        ),
      );

      expect(result.hasDataOnly, true);
      expect(result.data, true);
    });

    test('returns error if id is 0 (invalid)', () {
      final result = useCase(
        UpdateTaskParams(
          id: 0,
          name: 'Task Updated',
          status: 'done',
          userId: 5,
          dueDate: DateTime.now().add(Duration(days: 1)),
        ),
      );

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Required Valid id');
    });

    test('returns error if name is empty', () {
      final result = useCase(
        UpdateTaskParams(
          id: 1,
          name: '',
          status: 'done',
          userId: 3,
          dueDate: DateTime.now().add(Duration(days: 1)),
        ),
      );

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Required Input');
    });

    test('returns error if name is too short', () {
      final result = useCase(
        UpdateTaskParams(
          id: 1,
          name: 'Hi',
          description: 'How are you?',
          status: 'done',
          userId: 6,
          dueDate: DateTime.now().add(Duration(days: 1)),
        ),
      );

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'minimum length should be 3');
    });

    test('returns error if status is empty', () {
      final result = useCase(
        UpdateTaskParams(
          id: 1,
          name: 'Valid Name',
          status: '',
          userId: 6,
          dueDate: DateTime.now().add(Duration(days: 1)),
        ),
      );

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Required Input');
    });

    test('returns error if dueDate is in the past', () {
      final result = useCase(
        UpdateTaskParams(
          id: 1,
          name: 'Valid Name',
          status: 'blocked',
          userId: 9,
          dueDate: DateTime.now().subtract(Duration(days: 1)),
        ),
      );

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Date must be in the future');
    });
  });
}
