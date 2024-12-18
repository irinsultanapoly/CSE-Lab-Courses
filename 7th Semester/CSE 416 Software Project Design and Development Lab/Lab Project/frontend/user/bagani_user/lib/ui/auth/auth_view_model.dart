import 'package:bagani/data/models/auth/auth_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bagani/data/repositories/auth_repository.dart';
import 'package:logging/logging.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegistrationSuccess extends AuthState {
  AuthRegistrationSuccess();
}

class AuthLoginSuccess extends AuthState {
  final int id;

  AuthLoginSuccess(this.id);
}

class AuthViewModel extends StateNotifier<AsyncValue<AuthState>> {
  final AuthRepository authRepository;
  final _logger = Logger('AuthViewModel');

  AuthViewModel(this.authRepository) : super(AsyncValue.data(AuthInitial()));

  Future<void> register(RegisterRequest request) async {
    try {
      state = const AsyncValue.loading();
      _logger.info('Starting registration');
      await authRepository.register(request);
      state = AsyncValue.data(AuthRegistrationSuccess());
      _logger.info('Registration successful');
    } catch (e, s) {
      _logger.severe('Registration failed', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> login(LoginRequest request) async {
    try {
      state = const AsyncValue.loading();
      _logger.info('Starting login');
      int userId = await authRepository.login(request);
      state = AsyncValue.data(AuthLoginSuccess(userId));
      _logger.info('Login successful');
    } catch (e, s) {
      _logger.severe('Login failed', e, s);
      state = AsyncValue.error(e, s);
    }
  }
}
