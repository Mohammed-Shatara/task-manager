import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/data/data_sources/auth/auth_data_source.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/repositories/auth_repository_impl.dart';
import 'package:task_manager/data/requests/user_request.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('login', () {
    test('should return user on success', () async {
      final user = UserModel(
        id: 1,
        fullname: 'Ali',
        email: 'a@a.com',
        password: '123',
      );

      when(
        mockDataSource.login('a@a.com', '123'),
      ).thenAnswer((_) async => right(user));

      final result = await repository.login('a@a.com', '123');

      expect(result.hasDataOnly, true);
      expect(result.data!.email, 'a@a.com');
    });

    test('should return error on failure', () async {
      when(
        mockDataSource.login(any, any),
      ).thenAnswer((_) async => left(CustomError(message: 'fail')));

      final result = await repository.login('a@a.com', 'bad');

      expect(result.hasErrorOnly, true);
      expect(result.error, isA<CustomError>());
    });
  });

  group('createUser', () {
    final request = UserRequest(
      fullname: 'Sara',
      email: 's@s.comm',
      password: '12345678',
    );

    final createdUser = UserModel(
      id: 2,
      fullname: 'Sara',
      email: 's@s.com',
      password: '12345678',
    );

    test('should return user after creation and login', () async {
      when(
        mockDataSource.createUser(request),
      ).thenAnswer((_) async => right(1));

      when(
        mockDataSource.login(request.email, request.password),
      ).thenAnswer((_) async => right(createdUser));

      final result = await repository.createUser(request);

      expect(result.hasDataOnly, true);
      expect(result.data!.email, 's@s.com');
    });

    test('should return error if creation fails', () async {
      when(
        mockDataSource.createUser(any),
      ).thenAnswer((_) async => left(CustomError(message: 'exists')));

      final result = await repository.createUser(request);

      expect(result.hasErrorOnly, true);
    });

    test('should return error if login fails after creation', () async {
      when(
        mockDataSource.createUser(request),
      ).thenAnswer((_) async => right(3));

      when(
        mockDataSource.login(any, any),
      ).thenAnswer((_) async => left(CustomError(message: 'login failed')));

      final result = await repository.createUser(request);

      expect(result.hasErrorOnly, true);
    });
  });

  group('getUserById', () {
    test('should return user if found', () async {
      final user = UserModel(
        id: 1,
        fullname: 'Ziad',
        email: 'z@z.com',
        password: '123',
      );

      when(mockDataSource.getUserById(1)).thenAnswer((_) async => right(user));

      final result = await repository.getUserById(1);

      expect(result.hasDataOnly, true);
    });

    test('should return error if user not found', () async {
      when(
        mockDataSource.getUserById(any),
      ).thenAnswer((_) async => left(CustomError(message: 'not found')));

      final result = await repository.getUserById(99);

      expect(result.hasErrorOnly, true);
    });
  });
}
