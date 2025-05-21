import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/validators/email_validator.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:task_manager/core/validators/required_validator.dart';
import 'package:task_manager/domain/use_cases/auth/register_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/register_validator_use_case.dart';

void main() {
  late RegisterValidatorUseCase useCase;

  setUp(() {
    useCase = RegisterValidatorUseCase(
      requiredValidator: RequiredValidator(),
      emailValidator: EmailValidator(),
      passwordValidator: PasswordValidator(minLength: 6),
      minimumValidator: MinimumValidator(minLength: 3),
    );
  });

  test('returns true for valid fullName, email, and password', () {
    final result = useCase(
      RegisterParams(
        fullName: 'John Doe',
        email: 'john@example.com',
        password: '123456',
      ),
    );

    expect(result.hasDataOnly, true);
    expect(result.data, true);
  });

  test('returns error if fullName is too short', () {
    final result = useCase(
      RegisterParams(
        fullName: 'Jo',
        email: 'john@example.com',
        password: '123456',
      ),
    );

    expect(result.hasErrorOnly, true);
    expect(result.error.toString(), 'minimum length should be 3');
  });

  test('returns error if email is invalid', () {
    final result = useCase(
      RegisterParams(
        fullName: 'John Doe',
        email: 'bad_email',
        password: '123456',
      ),
    );

    expect(result.hasErrorOnly, true);
    expect(result.error.toString(), 'Invalid Email');
  });

  test('returns error if password is too short', () {
    final result = useCase(
      RegisterParams(
        fullName: 'John Doe',
        email: 'john@example.com',
        password: '123',
      ),
    );

    expect(result.hasErrorOnly, true);
    expect(result.error.toString(), 'password minimum length is 6');
  });

  test('returns error if fullName is empty', () {
    final result = useCase(
      RegisterParams(
        fullName: '',
        email: 'john@example.com',
        password: '123456',
      ),
    );

    expect(result.hasErrorOnly, true);
    expect(result.error.toString(), 'Required Input');
  });
}
