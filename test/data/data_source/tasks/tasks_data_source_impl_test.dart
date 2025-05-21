import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/data/data_sources/tasks/tasks_data_source_impl.dart';
import 'package:task_manager/data/database/dao/task_dao.dart';
import 'package:task_manager/data/requests/task_requests.dart';

import 'tasks_data_source_impl_test.mocks.dart';

@GenerateMocks([TaskDao])
void main() {
  late TasksDataSourceImpl dataSource;
  late MockTaskDao mockTaskDao;

  setUp(() {
    mockTaskDao = MockTaskDao();
    dataSource = TasksDataSourceImpl(mockTaskDao);
  });

  group('TasksDataSourceImpl', () {
    final testTaskRequest = TaskRequest(
      userId: 1,
      name: 'Test Task',
      description: 'Test Description',
      status: 'pending',
      dueDate: DateTime(2025, 5, 20),
    );

    final testUpdateRequest = UpdateTaskRequest(
      id: 5,
      userId: 1,
      name: 'Updated Task',
      description: 'Updated Description',
      status: 'done',
      dueDate: DateTime(2025, 6, 10),
    );

    test('createTask returns Right(id) when successful', () async {
      when(mockTaskDao.createTask(any)).thenAnswer((_) async => 42);

      final result = await dataSource.createTask(testTaskRequest);

      expect(result.isRight(), true);
      verify(mockTaskDao.createTask(testTaskRequest.toCompanion())).called(1);
    });

    test('createTask returns Left(error) when exception thrown', () async {
      when(mockTaskDao.createTask(any)).thenThrow(Exception('Insert error'));

      final result = await dataSource.createTask(testTaskRequest);

      expect(result.isLeft(), true);
      verify(mockTaskDao.createTask(any)).called(1);
    });

    test('updateTask returns Right(true) when successful', () async {
      when(mockTaskDao.updateTask(any)).thenAnswer((_) async => true);

      final result = await dataSource.updateTask(testUpdateRequest);

      expect(result.isRight(), true);
      verify(mockTaskDao.updateTask(testUpdateRequest.toCompanion())).called(1);
    });

    test('updateTask returns Left(error) when exception thrown', () async {
      when(mockTaskDao.updateTask(any)).thenThrow(Exception('Update error'));

      final result = await dataSource.updateTask(testUpdateRequest);

      expect(result.isLeft(), true);
      verify(mockTaskDao.updateTask(any)).called(1);
    });

    test('deleteTask returns Right(true) when successful', () async {
      when(mockTaskDao.deleteTask(1)).thenAnswer((_) async => 1);

      final result = await dataSource.deleteTask(1);

      expect(result.isRight(), true);
      verify(mockTaskDao.deleteTask(1)).called(1);
    });

    test('deleteTask returns Left(error) on failure', () async {
      when(mockTaskDao.deleteTask(1)).thenThrow(Exception('Delete error'));

      final result = await dataSource.deleteTask(1);

      expect(result.isLeft(), true);
      verify(mockTaskDao.deleteTask(1)).called(1);
    });
  });
}
