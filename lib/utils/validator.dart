



import 'package:EPW_mobile/utils/string_resource.dart';

class Validator {
  Validator._(_);
  static final RegExp _emailRegExp =
      RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

  static ValidationState validate(
    String? input, {
    required List<String> rules,
  }) {
    for (var i = 0; i < rules.length; i++) {
      final String rule = rules[i];
      if (rule == "required") {
        if (input == null || input.trim() == "") {
          return ValidationState(error: " ${StringResource.ISREQUIRED}");
        }
      }

      if (rule == 'bool') {
        if (input!.toLowerCase().trim() == "false") {
          return ValidationState(error: " ${StringResource.ISFALSE}");
        }
      }

      // if (rule == 'date') {
      //   if (input == StringConstants.ENTER_DATE) {
      //     return ValidationState(error: " ${StringResource.is_required}");
      //   }
      // }

      if (rule == "email") {
        if (input == null || input == "") {
          return ValidationState(error: " ${StringResource.ISREQUIRED}");
        }
        if (!_emailRegExp.hasMatch(input.trim())) {
          return ValidationState(
            error: " ${StringResource.INVALIDFORMAT}",
          );
        }
      }

      if (rule.startsWith("min:")) {
        try {
          final int letterCount = int.tryParse(rule.replaceAll("min:", ""))!;
          if (input!.length < letterCount) {
            return ValidationState(
              error:
                  "${StringResource.MIN} $letterCount ",
            );
          }
        } catch (_) {
          return ValidationState(
            error: " - $rule ${StringResource.INCRCTVALUE}",
          );
        }
      }
      if (rule.startsWith("max:")) {
        try {
          final int letterCount = int.tryParse(rule.replaceAll("max:", ""))!;
          if (input!.length > letterCount) {
            return ValidationState(
              error:
                  " ${StringResource.MAX} $letterCount",
            );
          }
        } catch (_) {
          return ValidationState(
            error: " - $rule ${StringResource.INCRCTVALUE}",
          );
        }
      }

      if (rule == "number_only") {
        final RegExp regex = RegExp(r"(\d+)");
        if (!regex.hasMatch(input!)) {
          return ValidationState(error: ' ${StringResource.NOTANUM}');
        }
      }
    }

    return ValidationState(status: true);
  }
}

class ValidationState {
  bool status;
  String? error;

  ValidationState({this.status = false, this.error});
}
