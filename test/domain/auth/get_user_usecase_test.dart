import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/repositories/auth_repository.dart';
import 'package:task_manager/domain/use_cases/auth/get_user_use_case.dart';

import 'get_user_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late GetUserUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetUserUseCase(authRepository: mockAuthRepository);
  });

  test('returns user when repository returns user', () async {
    final user = UserModel(
      id: 1,
      fullname: 'John',
      email: 'john@example.com',
      password: 'secret',
    );
    when(mockAuthRepository.getUserById(1))
        .thenAnswer((_) async => Result(data: user));

    final result = await useCase(1);

    expect(result.hasDataOnly, true);
    expect(result.data, user);
    verify(mockAuthRepository.getUserById(1)).called(1);
  });

  test('returns error when repository returns error', () async {
    final error = CustomError(message: 'User not found');
    when(mockAuthRepository.getUserById(2))
        .thenAnswer((_) async => Result(error: error));

    final result = await useCase(2);

    expect(result.hasErrorOnly, true);
    expect(result.error, error);
    verify(mockAuthRepository.getUserById(2)).called(1);
  });
}