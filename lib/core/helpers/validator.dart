class Validator {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[A-Za-z]{2,}");
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

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

    return null;
  }
}
