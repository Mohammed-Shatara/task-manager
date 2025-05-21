import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/data/data_sources/auth/auth_data_source_impl.dart';
import 'package:task_manager/data/database/dao/user_dao.dart';
import 'package:task_manager/data/database/tables/user_table.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/requests/user_request.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([UserDao])
void main() {
  late MockUserDao mockUserDao;
  late AuthDataSourceImpl dataSource;

  setUp(() {
    mockUserDao = MockUserDao();
    dataSource = AuthDataSourceImpl(mockUserDao);
  });

  group('login', () {
    test('should return UserModel on successful login', () async {
      final userFromDb = User(
        id: 1,
        fullname: 'John Doe',
        email: 'test@example.com',
        password: 'pass',
      );

      when(
        mockUserDao.login('test@example.com', 'pass'),
      ).thenAnswer((_) async => userFromDb);

      final result = await dataSource.login('test@example.com', 'pass');

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw 'error'), isA<UserModel>());
    });

    test('should return error when user is not found', () async {
      when(mockUserDao.login(any, any)).thenAnswer((_) async => null);

      final result = await dataSource.login('x@x.com', 'x');

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => throw 'error'), isA<CustomError>());
    });
  });

  group('createUser', () {
    test('should return user id when successful', () async {
      final userRequest = UserRequest(
        fullname: 'Jane',
        email: 'jane@test.com',
        password: '123',
      );

      when(
        mockUserDao.getUserByEmail(userRequest.email),
      ).thenAnswer((_) async => null);
      when(mockUserDao.createUser(any)).thenAnswer((_) async => 42);

      final result = await dataSource.createUser(userRequest);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => -1), 42);
    });

    test('should return error when email exists', () async {
      final existing = User(
        id: 1,
        fullname: 'Jane',
        email: 'jane@test.com',
        password: '123',
      );

      final userRequest = UserRequest(
        fullname: 'Jane',
        email: 'jane@test.com',
        password: '123',
      );

      when(
        mockUserDao.getUserByEmail(userRequest.email),
      ).thenAnswer((_) async => existing);

      final result = await dataSource.createUser(userRequest);

      expect(result.isLeft(), true);
    });
  });

  group('getUserById', () {
    test('should return user if exists', () async {
      final user = User(
        id: 10,
        fullname: 'Sam',
        email: 'sam@test.com',
        password: 'abc',
      );

      when(mockUserDao.getUserById(10)).thenAnswer((_) async => user);

      final result = await dataSource.getUserById(10);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw 'err').id, 10);
    });

    test('should return error if user not found', () async {
      when(mockUserDao.getUserById(any)).thenAnswer((_) async => null);

      final result = await dataSource.getUserById(5);

      expect(result.isLeft(), true);
    });
  });
}
