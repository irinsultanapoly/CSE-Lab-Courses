import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import '../core/logger/app_logger.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  // Check if secure storage is available for current platform
  bool get _isAvailable {
    // Secure storage is not available on web
    if (kIsWeb) {
      return false;
    }
    return true;
  }

  // Keys for stored data
  static const String _rememberMeKey = 'remember_me';
  static const String _savedEmailKey = 'saved_email';
  static const String _savedPasswordKey = 'saved_password';
  static const String _languageKey = 'language';
  static const String _themeModeKey = 'theme_mode';

  // Save remember me preference
  Future<void> saveRememberMePreference(bool rememberMe) async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return;
    }

    try {
      await _storage.write(key: _rememberMeKey, value: rememberMe.toString());
      AppLogger.i('Remember me preference saved: $rememberMe');
    } catch (e) {
      AppLogger.e('Failed to save remember me preference: $e');
      // Don't rethrow, just log the error to prevent app crashes
    }
  }

  // Get remember me preference
  Future<bool> getRememberMePreference() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return false;
    }

    try {
      final value = await _storage.read(key: _rememberMeKey);
      return value == 'true';
    } catch (e) {
      AppLogger.e('Failed to get remember me preference: $e');
      return false;
    }
  }

  // Save user credentials
  Future<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return;
    }

    try {
      await _storage.write(key: _savedEmailKey, value: email);
      await _storage.write(key: _savedPasswordKey, value: password);
      AppLogger.i('Credentials saved securely');
    } catch (e) {
      AppLogger.e('Failed to save credentials: $e');
      // Don't rethrow, just log the error to prevent app crashes
    }
  }

  // Get saved email
  Future<String?> getSavedEmail() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return null;
    }

    try {
      return await _storage.read(key: _savedEmailKey);
    } catch (e) {
      AppLogger.e('Failed to get saved email: $e');
      return null;
    }
  }

  // Get saved password
  Future<String?> getSavedPassword() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return null;
    }

    try {
      return await _storage.read(key: _savedPasswordKey);
    } catch (e) {
      AppLogger.e('Failed to get saved password: $e');
      return null;
    }
  }

  // Clear saved credentials
  Future<void> clearSavedCredentials() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return;
    }

    try {
      await _storage.delete(key: _savedEmailKey);
      await _storage.delete(key: _savedPasswordKey);
      await _storage.delete(key: _rememberMeKey);
      AppLogger.i('Saved credentials cleared');
    } catch (e) {
      AppLogger.e('Failed to clear saved credentials: $e');
      // Don't rethrow, just log the error to prevent app crashes
    }
  }

  // Check if credentials are saved
  Future<bool> hasSavedCredentials() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return false;
    }

    try {
      final email = await _storage.read(key: _savedEmailKey);
      final password = await _storage.read(key: _savedPasswordKey);
      return email != null && password != null;
    } catch (e) {
      AppLogger.e('Failed to check saved credentials: $e');
      return false;
    }
  }

  // Settings methods
  Future<void> saveLanguage(String language) async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return;
    }

    try {
      await _storage.write(key: _languageKey, value: language);
      AppLogger.i('Language saved: $language');
    } catch (e) {
      AppLogger.e('Failed to save language: $e');
    }
  }

  Future<String?> getLanguage() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return null;
    }

    try {
      return await _storage.read(key: _languageKey);
    } catch (e) {
      AppLogger.e('Failed to get language: $e');
      return null;
    }
  }

  Future<void> saveThemeMode(int themeModeIndex) async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return;
    }

    try {
      await _storage.write(
        key: _themeModeKey,
        value: themeModeIndex.toString(),
      );
      AppLogger.i('Theme mode saved: $themeModeIndex');
    } catch (e) {
      AppLogger.e('Failed to save theme mode: $e');
    }
  }

  Future<int?> getThemeMode() async {
    if (!_isAvailable) {
      AppLogger.w('Secure storage not available on this platform');
      return null;
    }

    try {
      final value = await _storage.read(key: _themeModeKey);
      return value != null ? int.tryParse(value) : null;
    } catch (e) {
      AppLogger.e('Failed to get theme mode: $e');
      return null;
    }
  }
}
