import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/error/custom_error.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/use_cases/auth/login_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/login_validator_use_case.dart';

void main() {
  late LoginValidatorUseCase useCase;

  setUp(() {
    useCase = LoginValidatorUseCase(
      requiredValidator: RequiredValidator(),
      emailValidator: EmailValidator(),
      passwordValidator: PasswordValidator(minLength: 6),
    );
  });

  test('returns true when email and password are valid', () {
    final result = useCase(
      LoginParams(email: 'test@example.com', password: '123456'),
    );

    expect(result.hasDataOnly, true);
    expect(result.data, true);
  });

  test('returns error if email is empty', () {
    final result = useCase(LoginParams(email: '', password: '123456'));

    expect(result.hasErrorOnly, true);
    expect((result.error as CustomError).message, 'Required Input');
  });

  test('returns error if email is invalid', () {
    final result = useCase(
      LoginParams(email: 'invalid_email', password: '123456'),
    );

    expect(result.hasErrorOnly, true);
    expect((result.error as CustomError).message, 'Invalid Email');
  });

  test('returns error if password is empty', () {
    final result = useCase(
      LoginParams(email: 'test@example.com', password: ''),
    );

    expect(result.hasErrorOnly, true);
    expect((result.error as CustomError).message, 'Required Input');
  });

  test('returns error if password is too short', () {
    final result = useCase(
      LoginParams(email: 'test@example.com', password: '123'),
    );

    expect(result.hasErrorOnly, true);
    expect(
      (result.error as CustomError).message,
      'password minimum length is 6',
    );
  });
}
