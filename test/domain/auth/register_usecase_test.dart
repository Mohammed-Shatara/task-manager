import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/repositories/auth_repository.dart';
import 'package:task_manager/domain/use_cases/auth/register_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/register_validator_use_case.dart';

import 'register_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RegisterValidatorUseCase validator;
  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase useCase;

  setUp(() {
    validator = RegisterValidatorUseCase(
      requiredValidator: RequiredValidator(),
      emailValidator: EmailValidator(),
      passwordValidator: PasswordValidator(minLength: 6),
      minimumValidator: MinimumValidator(minLength: 3),
    );

    mockAuthRepository = MockAuthRepository();

    useCase = RegisterUseCase(
      registerValidatorUseCase: validator,
      authRepository: mockAuthRepository,
    );
  });

  final validParams = RegisterParams(
    fullName: 'John Doe',
    email: 'john@example.com',
    password: 'password123',
  );

  final invalidParams = RegisterParams(
    fullName: 'Jo',          // minimumValidator (3)
    email: 'invalidemail',
    password: '123',         // PasswordValidator (6)
  );

  final userModel = UserModel(
    id: 1,
    fullname: 'John Doe',
    email: 'john@example.com',
    password: 'password123',
  );

  test('returns validation error when input is invalid', () async {
    final result = await useCase(invalidParams);

    expect(result.hasErrorOnly, true);
    expect(result.error, isNotNull);
    expect(result.error!.toString(), isNotEmpty);

    verifyNever(mockAuthRepository.createUser(any));
  });

  test('returns user model when validation passes and user created', () async {
    when(mockAuthRepository.createUser(any))
        .thenAnswer((_) async => Result(data: userModel));

    final result = await useCase(validParams);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);

    verify(mockAuthRepository.createUser(any)).called(1);
  });

  test('returns error when repository fails to create user', () async {
    final error = CustomError(message: 'Email already exists');

    when(mockAuthRepository.createUser(any))
        .thenAnswer((_) async => Result(error: error));

    final result = await useCase(validParams);

    expect(result.hasErrorOnly, true);
    expect(result.error, error);

    verify(mockAuthRepository.createUser(any)).called(1);
  });
}