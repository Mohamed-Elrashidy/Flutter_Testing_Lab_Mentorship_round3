/// ****************** FILE INFO ******************
/// File Name: validator.dart
/// Purpose: Provide form validators for email and password strength
/// Author: Mohamed Elrashidy
/// Created At: 17/10/2025

class Validator {
  /// Function Name: email
  ///
  /// Purpose: Validate an email string for presence and basic format.
  ///
  /// Parameters:
  /// - value: the input email string to validate
  ///
  /// Returns: String? -> null when valid, otherwise an error message
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Basic, practical email regex: checks local@domain.tld (with multi-level domains)
    final emailRegex = RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[A-Za-z]{2,}");
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null; // valid
  }

  /// Function Name: password
  ///
  /// Purpose: Validate password strength with configurable requirements.
  ///
  /// Parameters:
  /// - value: the input password string to validate
  /// - minLength: minimum required length (default 8)
  /// - requireUppercase: whether at least one uppercase letter is required (default true)
  /// - requireDigits: whether at least one digit is required (default true)
  /// - requireSpecial: whether at least one special character is required (default true)
  ///
  /// Returns: String? -> null when valid, otherwise an error message describing the missing requirements
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireDigits = true,
    bool requireSpecial = true,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final trimmed = value.trim();
    final missing = <String>[];

    if (trimmed.length < minLength) {
      return 'Password must be at least $minLength characters long.';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(trimmed)) {
      return "Password must contain an uppercase letter.";
    }

    if (requireDigits && !RegExp(r'\d').hasMatch(trimmed)) {
      return "Password must contain a digit.";
    }

    if (requireSpecial &&
        !RegExp(r'[!@#\$%\^&*(),.?":{}|<>_\-\[\]\\/]').hasMatch(trimmed)) {
      return "Password must contain a special character.";
    }

    return null; // valid
  }
}
