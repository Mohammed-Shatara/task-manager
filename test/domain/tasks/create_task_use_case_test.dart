import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/repositories/tasks_repository.dart';
import 'package:task_manager/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:task_manager/domain/use_cases/tasks/validations/task_validation_use_case.dart';

import 'create_task_use_case_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late MockTasksRepository mockRepository;
  late CreateTaskUseCase useCase;
  late TaskValidationUseCase validationUseCase;

  setUp(() {
    mockRepository = MockTasksRepository();

    validationUseCase = TaskValidationUseCase(
      requiredValidator: RequiredValidator(),
      minimumValidator: MinimumValidator(minLength: 3),
      dateValidator: DateValidator(),
    );

    useCase = CreateTaskUseCase(
      tasksRepository: mockRepository,
      taskValidationUseCase: validationUseCase,
    );
  });

  group('CreateTaskUseCase', () {
    final validParams = TaskParams(
      userId: 1,
      name: 'My Task',
      description: 'Optional',
      status: 'open',
      dueDate: DateTime.now().add(Duration(days: 1)),
    );

    test('returns error if validation fails (name too short)', () async {
      final invalidParams = TaskParams(
        userId: 1,
        name: 'Hi',
        description: 'desc',
        status: 'open',
        dueDate: DateTime.now().add(Duration(days: 1)),
      );

      final result = await useCase(invalidParams);

      expect(result.hasErrorOnly, true);
      expect(result.error, isA<CustomError>());
      expect(result.error?.toString(), contains('minimum length should be 3'));
    });

    test('returns error if due date is in the past', () async {
      final invalidParams = TaskParams(
        userId: 1,
        name: 'Valid Name',
        description: 'desc',
        status: 'open',
        dueDate: DateTime.now().subtract(Duration(days: 1)),
      );

      final result = await useCase(invalidParams);

      expect(result.hasErrorOnly, true);
      expect(result.error, isA<CustomError>());
      expect(result.error?.toString(), 'Date must be in the future');
    });

    test('calls repository and returns success when validation passes', () async {
      when(mockRepository.createTask(any)).thenAnswer((_) async => Result(data: 42));

      final result = await useCase(validParams);

      expect(result.hasDataOnly, true);
      expect(result.data, 42);

      verify(mockRepository.createTask(any)).called(1);
    });
  });
}
