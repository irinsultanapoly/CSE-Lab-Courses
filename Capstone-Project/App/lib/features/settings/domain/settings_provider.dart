import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../services/secure_storage_service.dart';
import '../../../core/logger/app_logger.dart';

// Settings state class
class SettingsState {
  final String language;
  final ThemeMode themeMode;
  final bool isLoading;

  const SettingsState({
    this.language = 'en',
    this.themeMode = ThemeMode.system,
    this.isLoading = false,
  });

  SettingsState copyWith({
    String? language,
    ThemeMode? themeMode,
    bool? isLoading,
  }) {
    return SettingsState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Settings notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  final SecureStorageService _secureStorage = SecureStorageService();

  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  // Load settings from secure storage
  Future<void> _loadSettings() async {
    try {
      state = state.copyWith(isLoading: true);

      final language = await _secureStorage.getLanguage() ?? 'en';
      final themeModeIndex =
          await _secureStorage.getThemeMode() ?? ThemeMode.system.index;
      final themeMode = ThemeMode.values[themeModeIndex];

      state = state.copyWith(
        language: language,
        themeMode: themeMode,
        isLoading: false,
      );

      AppLogger.i('Settings loaded: language=$language, themeMode=$themeMode');
    } catch (e) {
      AppLogger.e('Failed to load settings: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  // Update language
  Future<void> updateLanguage(String language) async {
    try {
      state = state.copyWith(isLoading: true);
      await _secureStorage.saveLanguage(language);

      state = state.copyWith(language: language, isLoading: false);

      AppLogger.i('Language updated to: $language');
    } catch (e) {
      AppLogger.e('Failed to update language: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  // Update theme mode
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    try {
      state = state.copyWith(isLoading: true);
      await _secureStorage.saveThemeMode(themeMode.index);
      
      state = state.copyWith(themeMode: themeMode, isLoading: false);
      
      AppLogger.i('Theme mode updated to: $themeMode');
    } catch (e) {
      AppLogger.e('Failed to update theme mode: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  // Get available languages
  List<Map<String, String>> get availableLanguages => [
    {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    {'code': 'bn', 'name': 'Bengali', 'nativeName': 'বাংলা'},
  ];

  // Get available theme modes
  List<Map<String, dynamic>> get availableThemeModes => [
    {'mode': ThemeMode.system, 'name': 'System Default'},
    {'mode': ThemeMode.light, 'name': 'Light'},
    {'mode': ThemeMode.dark, 'name': 'Dark'},
  ];
}

// Settings provider
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);
