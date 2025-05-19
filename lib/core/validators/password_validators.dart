import 'base_validator.dart';

class PasswordValidator extends BaseValidator<String> {
  final int minLength;

  PasswordValidator({required this.minLength});

  @override
  String getValidateMessage() {
    return 'password minimum length is $minLength';
  }

  @override
  bool validateFunction(String? value) {
    return value != null
        ? value.length >= minLength
            ? true
            : false
        : false;
  }
}

class MinimumValidator extends BaseValidator<String> {
  final int minLength;

  MinimumValidator({required this.minLength});

  @override
  String getValidateMessage() {
    return 'minimum length should be $minLength';
  }

  @override
  bool validateFunction(String? value) {
    return value != null
        ? value.length >= minLength
            ? true
            : false
        : false;
  }
}

class MatchValidator extends BaseValidator<String> {
  final String? text;

  MatchValidator({required this.text});

  @override
  String getValidateMessage() {
    return "the password doesn't match.";
  }

  @override
  bool validateFunction(String? value) {
    return value != null
        ? value == text
            ? true
            : false
        : false;
  }
}
