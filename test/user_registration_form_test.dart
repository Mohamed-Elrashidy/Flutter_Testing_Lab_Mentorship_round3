/// ****************** FILE INFO ******************
/// File Name: user_registration_form_test.dart
/// Purpose: Widget tests for user registration form behavior and validation
/// Author: Mohamed Elrashidy
/// Created At: 17/10/2025

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  testWidgets("test start form rendering", (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    var nameField = find.widgetWithText(TextFormField, "Full Name");
    expect(nameField, findsOneWidget);

    var emailField = find.widgetWithText(TextFormField, "Email");
    expect(emailField, findsOneWidget);

    var passwordField = find.widgetWithText(TextFormField, "Password");
    expect(passwordField, findsOneWidget);

    var confirmPasswordField = find.widgetWithText(
      TextFormField,
      "Confirm Password",
    );
    expect(confirmPasswordField, findsOneWidget);

    var submitButton = find.widgetWithText(ElevatedButton, "Register");
    expect(submitButton, findsOneWidget);
  });

  group('test email validation cases', () {
    testWidgets("Empty Email", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var emailField = find.widgetWithText(TextFormField, "Email");
      await widgetTester.enterText(emailField, "");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(find.text("Email is required"), findsOneWidget);
    });

    testWidgets("invalid email", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var emailField = find.widgetWithText(TextFormField, "Email");
      await widgetTester.enterText(emailField, "meahef");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(find.text("Enter a valid email address"), findsOneWidget);
    });
  });

  group('test password validation cases', () {
    testWidgets("Empty Password", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var passwordField = find.widgetWithText(TextFormField, "Password");
      await widgetTester.enterText(passwordField, "");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(find.text("Password is required"), findsOneWidget);
    });
    testWidgets("Weak Password min length", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var passwordField = find.widgetWithText(TextFormField, "Password");
      await widgetTester.enterText(passwordField, "Ab1!");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(
        find.text("Password must be at least 8 characters long."),
        findsOneWidget,
      );
    });

    testWidgets("Weak Password missing uppercase", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var passwordField = find.widgetWithText(TextFormField, "Password");
      await widgetTester.enterText(passwordField, "ab1!abcd");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(
        find.text("Password must contain an uppercase letter."),
        findsOneWidget,
      );
    });

    testWidgets("Weak Password missing digit", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var passwordField = find.widgetWithText(TextFormField, "Password");
      await widgetTester.enterText(passwordField, "Abcdefgh!");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(find.text("Password must contain a digit."), findsOneWidget);
    });

    testWidgets("Weak Password missing special character", (
      widgetTester,
    ) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );
      var passwordField = find.widgetWithText(TextFormField, "Password");
      await widgetTester.enterText(passwordField, "Abcdefg1");
      await widgetTester.pump();
      var submitButton = find.widgetWithText(ElevatedButton, "Register");
      await widgetTester.tap(submitButton);
      await widgetTester.pump();
      expect(
        find.text("Password must contain a special character."),
        findsOneWidget,
      );
    });
  });
}
