import 'package:qent/generated/l10n.dart';

class Validator {
  static String? isValidEmail(String? value) {
    if (value == null || value.isEmpty) return S.current.emailIsRequired;

    final isValid = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(value);

    return isValid ? null : S.current.enterValidEmail;
  }

  static String? isValidPassword(String? value) {
    if (value == null || value.isEmpty) return S.current.passwordIsRequired;

    final isValid = value.trim().length >= 8;

    return isValid ? null : S.current.passwordMustBeAtLeast8Characters;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return S.current.confirmPasswordIsRequired;
    }

    final isValid = value.trim() == password?.trim();

    return isValid ? null : S.current.passwordsNotMatch;
  }

  static String? isValidName(String? value) {
    if (value == null || value.isEmpty) return S.current.nameIsRequired;

    return value.trim().length >= 3
        ? null
        : S.current.nameMustBeAtLeast3Characters;
  }

  static String? isValidField(String? value) {
    if (value == null || value.isEmpty) return S.current.fieldIsRequired;
    return null;
  }

  static String? isValidPhoneNumber(String? value) {
    if (value == null || value.isEmpty) return S.current.phoneNumberIsRequired;

    final isValid = value.trim().length == 10;

    return isValid ? null : S.current.phoneNumberMustBe10Digits;
  }

  static String? isValidNID(String? value) {
    if (value == null || value.isEmpty) return S.current.nationalIDIsRequired;

    final isValid = value.trim().length == 14;

    return isValid ? null : S.current.nationalIDMustBe14Digits;
  }
}
