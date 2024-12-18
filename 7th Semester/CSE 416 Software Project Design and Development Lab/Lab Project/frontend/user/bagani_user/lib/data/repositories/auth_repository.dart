import 'package:bagani/data/models/auth/auth_response.dart';
import 'package:bagani/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../models/auth/auth_request.dart';

class AuthRepository {
  final AuthService authService;
  final _logger = Logger('AuthRepository');

  AuthRepository(this.authService);

  Future<bool> register(RegisterRequest request) async {
    await authService.register(request);
    return true;
  }

  Future<int> login(LoginRequest request) async {
    final loginResult = await authService.login(request);
    if (loginResult.data is LoginData) {
      return loginResult.data!.userId;
    } else {
      _logger.severe('Login data not present.');
      throw Exception('Login data not present.');
    }
  }

  Future<void> logout() async {
    try {
      _logger.info('Logging out the user');
      await authService.logout(); // Call the logout method in AuthService
      _logger.info('User logged out successfully');
    } catch (e) {
      _logger.severe('Error during logout', e);
      rethrow; // Rethrow for higher-level handling if needed
    }
  }
}
