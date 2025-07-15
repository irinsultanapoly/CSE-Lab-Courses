import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../services/secure_storage_service.dart';
import '../../../core/logger/app_logger.dart';

// Provider for FirebaseAuthService
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// Provider for SecureStorageService
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

// Provider for current user
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

// Provider for authentication state
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
      final authService = ref.watch(firebaseAuthServiceProvider);
      final secureStorage = ref.watch(secureStorageServiceProvider);
      return AuthStateNotifier(authService, secureStorage);
    });

// Auth state notifier
class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuthService _authService;
  final SecureStorageService _secureStorage;

  AuthStateNotifier(this._authService, this._secureStorage)
    : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
      AppLogger.i('Auth state changed: ${user?.uid ?? 'No user'}');
    });
  }

  // Sign up
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      state = const AsyncValue.loading();
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      AppLogger.i('Sign up completed successfully');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      AppLogger.e('Sign up failed: $e');
      rethrow;
    }
  }

  // Sign in
  Future<void> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      state = const AsyncValue.loading();
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save credentials if remember me is enabled
      if (rememberMe) {
        try {
          await _secureStorage.saveCredentials(
            email: email,
            password: password,
          );
          await _secureStorage.saveRememberMePreference(true);
          AppLogger.i('Credentials saved for remember me');
        } catch (e) {
          AppLogger.w(
            'Failed to save credentials, but login was successful: $e',
          );
        }
      } else {
        // Clear saved credentials if remember me is disabled
        try {
          await _secureStorage.clearSavedCredentials();
          AppLogger.i('Saved credentials cleared');
        } catch (e) {
          AppLogger.w('Failed to clear credentials: $e');
        }
      }

      AppLogger.i('Sign in completed successfully');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      AppLogger.e('Sign in failed: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      AppLogger.i('Sign out completed successfully');
    } catch (e) {
      AppLogger.e('Sign out failed: $e');
      rethrow;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      AppLogger.i('Password reset email sent successfully');
    } catch (e) {
      AppLogger.e('Password reset email failed: $e');
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _authService.updateUserProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      AppLogger.i('User profile updated successfully');
    } catch (e) {
      AppLogger.e('Profile update failed: $e');
      rethrow;
    }
  }

  // Delete user account
  Future<void> deleteUserAccount() async {
    try {
      await _authService.deleteUserAccount();
      AppLogger.i('User account deleted successfully');
    } catch (e) {
      AppLogger.e('Account deletion failed: $e');
      rethrow;
    }
  }

  // Get current user
  User? get currentUser => _authService.currentUser;

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // Get saved credentials
  Future<Map<String, String?>> getSavedCredentials() async {
    try {
      final email = await _secureStorage.getSavedEmail();
      final password = await _secureStorage.getSavedPassword();
      return {'email': email, 'password': password};
    } catch (e) {
      AppLogger.e('Failed to get saved credentials: $e');
      return {'email': null, 'password': null};
    }
  }

  // Check if remember me is enabled
  Future<bool> isRememberMeEnabled() async {
    try {
      return await _secureStorage.getRememberMePreference();
    } catch (e) {
      AppLogger.e('Failed to check remember me preference: $e');
      return false;
    }
  }

  // Clear saved credentials
  Future<void> clearSavedCredentials() async {
    try {
      await _secureStorage.clearSavedCredentials();
      AppLogger.i('Saved credentials cleared');
    } catch (e) {
      AppLogger.e('Failed to clear saved credentials: $e');
      rethrow;
    }
  }
}
