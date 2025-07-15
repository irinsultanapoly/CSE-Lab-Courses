import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/screen_title.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/settings_provider.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../l10n/app_localizations.dart';

class ThemeSelectionScreen extends ConsumerStatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  ConsumerState<ThemeSelectionScreen> createState() =>
      _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends ConsumerState<ThemeSelectionScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return LoadingOverlay(
      isLoading: _isLoading,
      message: AppLocalizations.of(context)!.updatingTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ScreenTitle(title: AppLocalizations.of(context)!.theme),
                    const SizedBox(height: 32),

                    // Theme options
                    Expanded(
                      child: ListView.builder(
                        itemCount: ref
                            .read(settingsProvider.notifier)
                            .availableThemeModes
                            .length,
                        itemBuilder: (context, index) {
                          final themeMode = ref
                              .read(settingsProvider.notifier)
                              .availableThemeModes[index];
                          final isSelected =
                              settings.themeMode == themeMode['mode'];

                          return _buildThemeCard(
                            context,
                            themeMode: themeMode,
                            isSelected: isSelected,
                            onTap: () => _selectTheme(themeMode['mode']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context, {
    required Map<String, dynamic> themeMode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final mode = themeMode['mode'] as ThemeMode;
    final name = themeMode['name'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppTheme.accentGreen : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Theme icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.accentGreen.withOpacity(0.1)
                      : AppTheme.lightText.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getThemeIcon(mode),
                  color: isSelected
                      ? AppTheme.accentGreen
                      : AppTheme.mediumText,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Theme info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppTheme.accentGreen
                            : AppTheme.darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getThemeDescription(context, mode),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumText,
                      ),
                    ),
                  ],
                ),
              ),

              // Selection indicator
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }

  String _getThemeDescription(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return AppLocalizations.of(context)!.followsDeviceSettings;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.lightThemeDescription;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.darkThemeDescription;
    }
  }

  Future<void> _selectTheme(ThemeMode themeMode) async {
    if (ref.read(settingsProvider).themeMode == themeMode) {
      return; // Already selected
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(settingsProvider.notifier).updateThemeMode(themeMode);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.themeUpdatedTo(_getThemeName(themeMode)),
            ),
            backgroundColor: AppTheme.accentGreen,
          ),
        );

        // Navigate back
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.failedToUpdateTheme(e.toString()),
            ),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
