import 'base_validator.dart';

class UrlValidator extends BaseValidator<String> {
  @override
  String getValidateMessage() {
    return "Invalid Url";
  }

  @override
  bool validateFunction(String? value) {
    final val = value ?? '';
    String regexString =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    final regex = RegExp(regexString, caseSensitive: false);
    return regex.hasMatch(val);
  }
}
