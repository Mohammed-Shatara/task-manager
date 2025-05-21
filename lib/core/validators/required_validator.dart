import 'package:intl/intl.dart';

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

class DateAsStringValidator extends BaseValidator<String> {
  @override
  String getValidateMessage() => "Date must be in the future";

  @override
  bool validateFunction(String? value) {
    if (value == null) return false;
    final format = DateFormat('dd/MMM/yyyy – hh:mm a');
    DateTime? date = format.tryParse(value);
    if (date == null) return false;
    return date.isAfter(DateTime.now());
  }
}

class IdRequiredValidator extends BaseValidator<String> {
  @override
  String getValidateMessage() {
    return "Required Valid id";
  }

  @override
  bool validateFunction(String? value) {
    int? number = int.tryParse(value?? '0');
    return number != null && number>0;
  }
}