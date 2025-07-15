import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../domain/settings_provider.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),

              const SizedBox(height: 40),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Section
                      _buildSectionTitle(
                        context,
                        AppLocalizations.of(context)!.account,
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsCard(
                        context,
                        Icons.person_rounded,
                        AppLocalizations.of(context)!.profile,
                        AppLocalizations.of(context)!.manageAccountInfo,
                        onTap: () {
                          GoRouter.of(context).push('/profile');
                        },
                      ),

                      const SizedBox(height: 32),

                      // App Settings
                      _buildSectionTitle(
                        context,
                        AppLocalizations.of(context)!.appSettings,
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsCard(
                        context,
                        Icons.language_rounded,
                        AppLocalizations.of(context)!.language,
                        _getLanguageName(settings.language),
                        onTap: () {
                          context.push(AppRoutes.languageSelection);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        context,
                        Icons.dark_mode_rounded,
                        AppLocalizations.of(context)!.theme,
                        _getThemeName(settings.themeMode),
                        onTap: () {
                          context.push(AppRoutes.themeSelection);
                        },
                      ),

                      const SizedBox(height: 32),

                      // Support
                      _buildSectionTitle(
                        context,
                        AppLocalizations.of(context)!.support,
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsCard(
                        context,
                        Icons.help_rounded,
                        AppLocalizations.of(context)!.helpSupport,
                        AppLocalizations.of(context)!.getHelpAndContact,
                        onTap: () {
                          context.push(AppRoutes.helpSupport);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        context,
                        Icons.info_rounded,
                        AppLocalizations.of(context)!.about,
                        AppLocalizations.of(context)!.appVersionAndInfo,
                        onTap: () {
                          context.push(AppRoutes.about);
                        },
                      ),

                      const SizedBox(height: 100), // Bottom padding for nav bar
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTheme.darkText,
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
    bool showTrailing = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppTheme.accentGreen, size: 26),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.mediumText),
                  ),
                ],
              ),
            ),
            if (showTrailing)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'bn':
        return 'বাংলা (Bengali)';
      default:
        return 'English';
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
