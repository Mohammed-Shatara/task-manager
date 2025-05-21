import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/repositories/tasks_repository.dart';
import 'package:task_manager/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

import 'create_task_use_case_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late MockTasksRepository mockRepository;
  late UpdateTaskUseCase useCase;
  late UpdateTaskValidationUseCase validationUseCase;

  setUp(() {
    mockRepository = MockTasksRepository();

    validationUseCase = UpdateTaskValidationUseCase(
      idRequiredValidator: IdRequiredValidator(),
      requiredValidator: RequiredValidator(),
      minimumValidator: MinimumValidator(minLength: 3),
      dateValidator: DateValidator(),
    );

    useCase = UpdateTaskUseCase(
      tasksRepository: mockRepository,
      updateTaskValidationUseCase: validationUseCase,
    );
  });

  group('UpdateTaskUseCase', () {
    final validParams = UpdateTaskParams(
      id: 1,
      userId: 2,
      name: 'Updated Task',
      description: 'Updated description',
      status: 'pending',
      dueDate: DateTime.now().add(Duration(days: 2)),
    );

    test('returns error if validation fails (empty name)', () async {
      final invalidParams = UpdateTaskParams(
        id: 1,
        userId: 2,
        name: '',
        description: 'desc',
        status: 'done',
        dueDate: DateTime.now().add(Duration(days: 2)),
      );

      final result = await useCase(invalidParams);

      expect(result.hasErrorOnly, true);
      expect(result.error, isA<CustomError>());
      expect(result.error?.toString(), 'Required Input');
    });

    test('returns error if due date is in the past', () async {
      final invalidParams = UpdateTaskParams(
        id: 1,
        userId: 2,
        name: 'Valid Name',
        description: 'desc',
        status: 'pending',
        dueDate: DateTime.now(),
      );

      final result = await useCase(invalidParams);

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'Date must be in the future');
    });

    test('returns error if name is too short', () async {
      final invalidParams = UpdateTaskParams(
        id: 1,
        name: 'Hi',
        description: 'description',
        status: 'blocked',

        userId: 2,

        dueDate: DateTime.now().add(Duration(days: 2)),
      );

      final result = await useCase(invalidParams);

      expect(result.hasErrorOnly, true);
      expect(result.error?.toString(), 'minimum length should be 3');
    });

    test('calls repository and returns success when valid', () async {
      when(
        mockRepository.updateTask(any),
      ).thenAnswer((_) async => Result(data: true));

      final result = await useCase(validParams);

      expect(result.hasDataOnly, true);
      expect(result.data, true);

      verify(mockRepository.updateTask(any)).called(1);
    });
  });
}
