import 'base_validator.dart';

class RequiredValidator extends BaseValidator<String> {
  @override
  String getValidateMessage() {
    return "Required Input";
  }

  @override
  bool validateFunction(String? value) {
    return value != null && value.isNotEmpty;
  }
}

class DateValidator extends BaseValidator<DateTime> {
  @override
  String getValidateMessage() => "Date must be in the future";

  @override
  bool validateFunction(DateTime? value) {
    if (value == null) return false;
    return value.isAfter(DateTime.now());
  }
}
