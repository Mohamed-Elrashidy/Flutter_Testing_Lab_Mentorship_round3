/// ****************** FILE INFO ******************
/// File Name: validator_test.dart
/// Purpose: Unit tests for email and password validators
/// Author: Mohamed Elrashidy
/// Created At: 17/10/2025

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/core/helpers/validator.dart';

void main() {
  group('Validator.email', () {
    test('returns error when email is null', () {
      expect(Validator.email(null), 'Email is required');
    });

    test('returns error when email is empty', () {
      expect(Validator.email(''), 'Email is required');
    });

    test('returns error for invalid email', () {
      expect(Validator.email('not-an-email'), 'Enter a valid email address');
    });

    test('returns null for valid email', () {
      expect(Validator.email('test@example.com'), isNull);
    });
  });

  group('Validator.password', () {
    test('returns error when password is null', () {
      expect(Validator.password(null), 'Password is required');
    });

    test('returns length error when too short', () {
      // "Short1!" is 7 chars, default minLength is 8
      expect(
        Validator.password('Short1!'),
        'Password must contain at least 8 characters.',
      );
    });

    test('returns multiple requirement errors', () {
      // no uppercase, no digit, no special char, but length is 8
      final msg = Validator.password('password');
      expect(
        msg,
        'Password must contain an uppercase letter, a number and a special character.',
      );
    });

    test('accepts a strong password', () {
      expect(Validator.password('Str0ng!Pass'), isNull);
    });

    test('configurable requirements: allow no special char', () {
      // when special chars are not required, the password below should be valid
      final result = Validator.password('Password1', requireSpecial: false);
      expect(result, isNull);
    });
  });
}
