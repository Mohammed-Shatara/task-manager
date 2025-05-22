import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/services/internet_checker_service.dart';
import 'package:task_manager/data/data_sources/tasks/remote/tasks_remote_data_source.dart';
import 'package:task_manager/data/data_sources/tasks/tasks_data_source.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/repositories/tasks_repository_impl.dart';
import 'package:task_manager/data/requests/task_requests.dart';

import 'tasks_repository_impl_test.mocks.dart';

@GenerateMocks([
  TasksDataSource,
  TasksRemoteDataSource,
  InternetConnectionService,
])
void main() {
  late MockTasksDataSource mockDataSource;
  late MockTasksRemoteDataSource mockRemoteDataSource;
  late MockInternetConnectionService mockInternetConnectionService;

  late TasksRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockTasksDataSource();
    mockRemoteDataSource = MockTasksRemoteDataSource();
    mockInternetConnectionService = MockInternetConnectionService();

    repository = TasksRepositoryImpl(
      tasksDataSource: mockDataSource,
      tasksRemoteDataSource: mockRemoteDataSource,
      internetConnectionService: mockInternetConnectionService,
    );
  });

  group('TasksRepositoryImpl', () {
    final taskRequest = TaskRequest(
      userId: 1,
      name: 'Test Task',
      description: 'Some desc',
      status: 'pending',
      dueDate: DateTime(2025, 5, 20),
    );

    final updateRequest = UpdateTaskRequest(
      id: 5,
      userId: 1,
      name: 'Updated Task',
      description: 'Updated desc',
      status: 'done',
      dueDate: DateTime(2025, 6, 1),
    );

    final testTaskModel = TaskModel(
      id: 1,
      userId: 1,
      name: 'Test Task',
      description: 'Some desc',
      status: 'pending',
      dueDate: DateTime(2025, 5, 20),
    );

    test('createTask returns Result with data when successful', () async {
      when(
        mockDataSource.createTask(taskRequest),
      ).thenAnswer((_) async => right(100));

      final result = await repository.createTask(taskRequest);

      expect(result.hasDataOnly, true);
      expect(result.data, 100);
      verify(mockDataSource.createTask(taskRequest)).called(1);
    });

    test('updateTask returns Result with data when successful', () async {
      when(
        mockDataSource.updateTask(updateRequest),
      ).thenAnswer((_) async => right(true));

      final result = await repository.updateTask(updateRequest);

      expect(result.hasDataOnly, true);
      expect(result.data, true);
      verify(mockDataSource.updateTask(updateRequest)).called(1);
    });

    test('getTaskById returns Result with data when successful', () async {
      when(
        mockDataSource.getTaskById(1),
      ).thenAnswer((_) async => right(testTaskModel));

      final result = await repository.getTaskById(1);

      expect(result.hasDataOnly, true);
      expect(result.data, testTaskModel);
      verify(mockDataSource.getTaskById(1)).called(1);
    });

    test('deleteTask returns Result with error when failed', () async {
      final error = CustomError(message: 'Failed');
      when(mockDataSource.deleteTask(1)).thenAnswer((_) async => left(error));

      final result = await repository.deleteTask(1);

      expect(result.hasErrorOnly, true);
      expect(result.error, error);
      verify(mockDataSource.deleteTask(1)).called(1);
    });
  });
}
