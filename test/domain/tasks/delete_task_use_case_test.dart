import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/domain/repositories/tasks_repository.dart';
import 'package:task_manager/domain/use_cases/tasks/delete_task_use_case.dart';

import 'delete_task_use_case_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late MockTasksRepository mockRepository;
  late DeleteTaskUseCase useCase;

  setUp(() {
    mockRepository = MockTasksRepository();
    useCase = DeleteTaskUseCase(tasksRepository: mockRepository);
  });

  const taskId = 1;

  test('should return success result from repository', () async {
    when(
      mockRepository.deleteTask(taskId),
    ).thenAnswer((_) async => Result(data: true));

    final result = await useCase(taskId);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(mockRepository.deleteTask(taskId)).called(1);
  });

  test('should return error result from repository', () async {
    final error = CustomError(message: 'Deletion failed');
    when(
      mockRepository.deleteTask(taskId),
    ).thenAnswer((_) async => Result(error: error));

    final result = await useCase(taskId);

    expect(result.hasErrorOnly, true);
    expect(result.error, error);
    verify(mockRepository.deleteTask(taskId)).called(1);
  });
}
