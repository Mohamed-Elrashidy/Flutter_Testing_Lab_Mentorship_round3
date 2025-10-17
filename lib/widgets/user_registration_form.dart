/// ****************** FILE INFO ******************
/// File Name: user_registration_form.dart
/// Purpose: Provide a user registration form with validation and guarded submission
/// Author: Mohamed Elrashidy
/// Created At: 17/10/2025

import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/helpers/validator.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  String _message = '';

  /// Function Name: isValidEmail
  ///
  /// Purpose: Validate email string using a regex pattern
  ///
  /// Parameters:
  /// - email: the email string to validate
  ///
  /// Returns: bool indicating if email is valid
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$',
      caseSensitive: false,
    );
    return emailRegExp.hasMatch(email);
  }

  /// Function Name: isValidPassword
  ///
  /// Purpose: Validate password strength (at least 8 chars, contains a digit and a symbol)
  ///
  /// Parameters:
  /// - password: the password string to validate
  ///
  /// Returns: bool indicating if password meets criteria
  bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'\d').hasMatch(password)) return false;
    if (!RegExp(r'[!@#\$%^&*~\-\+]').hasMatch(password)) return false;
    return true;
  }

  /// Function Name: _submitForm
  ///
  /// Purpose: Perform submission logic (shows loading, simulates API call, sets message)
  ///
  /// Parameters:
  /// - none
  ///
  /// Returns: Future<void>
  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _message = 'Registration successful!';
    });
  }

  /// Function Name: build
  ///
  /// Purpose: Build the registration form UI
  ///
  /// Parameters:
  /// - context: BuildContext for widget building
  ///
  /// Returns: Widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                if (value.length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return Validator.email(value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                helperText: 'At least 8 characters with numbers and symbols',
              ),
              obscureText: true,
              validator: (value) {
                return Validator.password(value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      // Validate form first; do not submit until all validators pass
                      if (!(_formKey.currentState?.validate() ?? false)) {
                        setState(() {
                          _message = 'Please fix the errors before submitting.';
                        });
                        return;
                      }
                      await _submitForm();
                    },
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Register'),
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains('successful')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Function Name: dispose
  ///
  /// Purpose: Dispose controllers to free resources
  ///
  /// Parameters:
  /// - none
  ///
  /// Returns: void
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
