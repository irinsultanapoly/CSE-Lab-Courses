import 'package:bagani/config/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bagani/data/models/auth/auth_request.dart';
import 'package:go_router/go_router.dart';

import 'auth_view_model.dart';

class AuthView extends ConsumerStatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLogin = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final request = RegisterRequest(
        name: _nameController.text,
        mobile: _mobileController.text,
        password: _passwordController.text,
        email: _emailController.text,
      );

      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.register(request);
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final request = LoginRequest(
        mobile: _mobileController.text,
        password: _passwordController.text,
      );

      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.login(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(
      authViewModelProvider,
      (previous, next) {
        next.when(
          data: (state) {
            Navigator.of(context, rootNavigator: true)
                .pop(); // Close the loading dialog
            if (state is AuthRegistrationSuccess) {
              //Registration success now need to login
              setState(() {
                _isLogin = true;
              });
              _passwordController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Registration successful! Please login now.')),
              );
            } else if (state is AuthLoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login successful!')),
              );
              context.go('/${state.id}');
            }
          },
          loading: () => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) {
            Navigator.of(context, rootNavigator: true)
                .pop(); // Close the loading dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            CircleAvatar(
              radius: 50, // Adjust size as needed
              backgroundImage: AssetImage(
                  'assets/img/app_icon.png'), // Path to your app icon
              backgroundColor:
                  Colors.transparent, // Optional: Transparent background
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!_isLogin)
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(labelText: 'Mobile'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email (optional)',
                          ),
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: _isLogin ? _login : _register,
                          child: Text(_isLogin ? 'Login' : 'Register'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Don\'t have an account? Register'
                            : 'Already have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
