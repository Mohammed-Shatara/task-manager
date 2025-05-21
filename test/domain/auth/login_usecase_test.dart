import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/result/result.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/repositories/auth_repository.dart';
import 'package:task_manager/domain/use_cases/auth/login_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/login_validator_use_case.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginValidatorUseCase, AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late LoginValidatorUseCase validator;

  final loginParams = LoginParams(email: 'user@test.com', password: '123456');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    validator = LoginValidatorUseCase(
      requiredValidator: RequiredValidator(),
      emailValidator: EmailValidator(),
      passwordValidator: PasswordValidator(minLength: 6),
    );

    useCase = LoginUseCase(
      loginValidatorUseCase: validator,
      authRepository: mockAuthRepository,
    );
  });

  test('returns user when validation passes and login succeeds', () async {
    final user = UserModel(
      id: 1,
      fullname: 'User Test',
      email: 'user@test.com',
      password: '123456',
    );

    when(
      mockAuthRepository.login(loginParams.email, loginParams.password),
    ).thenAnswer((_) async => Result(data: user));

    final result = await useCase(loginParams);

    expect(result.hasDataOnly, true);
    expect(result.data, user);

    verify(
      mockAuthRepository.login(loginParams.email, loginParams.password),
    ).called(1);
  });

  test('returns validation error and skips repository call', () async {
    final invalidParams = LoginParams(email: '', password: ''); // invalid input

    final result = await useCase(invalidParams);

    expect(result.hasErrorOnly, true);
    expect(result.error?.toString(), 'Required Input');

    verifyNever(mockAuthRepository.login(any, any));
  });
}
