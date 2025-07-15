import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/screen_title.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../domain/profile_provider.dart';
import '../../auth/domain/auth_provider.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../l10n/app_localizations.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileStateProvider);

    return LoadingOverlay(
      isLoading: _isLoading,
      message: AppLocalizations.of(context)!.processing,
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
                child: profileState.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: AppTheme.errorRed,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading profile: $error',
                          style: TextStyle(color: AppTheme.errorRed),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  data: (profile) => profile == null
                      ? const Center(child: Text('No profile data available'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            ScreenTitle(
                              title: AppLocalizations.of(context)!.profile,
                            ),
                            const SizedBox(height: 32),
                            // Avatar
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.green.withOpacity(0.15),
                              backgroundImage: profile.localImagePath != null
                                  ? FileImage(File(profile.localImagePath!))
                                  : (profile.avatarUrl != null
                                        ? NetworkImage(profile.avatarUrl!)
                                              as ImageProvider
                                        : null),
                              child:
                                  profile.localImagePath == null &&
                                      profile.avatarUrl == null
                                  ? const Icon(
                                      Icons.person_rounded,
                                      size: 60,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 24),
                            // Name
                            Text(
                              profile.name,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            // Email
                            Text(
                              profile.email,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black54),
                            ),
                            const SizedBox(height: 32),

                            // Profile Actions
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Edit Profile Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      icon: const Icon(Icons.edit_rounded),
                                      label: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.editProfile,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.accentGreen,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () {
                                        context.push('/edit-profile');
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Sign Out Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      icon: const Icon(Icons.logout_rounded),
                                      label: Text(
                                        AppLocalizations.of(context)!.signOut,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppTheme.errorRed,
                                        side: BorderSide(
                                          color: AppTheme.errorRed,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () =>
                                          _showSignOutDialog(context, ref),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Clear Saved Credentials Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      icon: const Icon(
                                        Icons.cleaning_services_rounded,
                                      ),
                                      label: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.clearSavedCredentials,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppTheme.mediumText,
                                        side: BorderSide(
                                          color: AppTheme.mediumText
                                              .withOpacity(0.5),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () =>
                                          _showClearCredentialsDialog(
                                            context,
                                            ref,
                                          ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Delete Account Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      icon: const Icon(
                                        Icons.delete_forever_rounded,
                                      ),
                                      label: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.deleteAccount,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppTheme.errorRed,
                                        side: BorderSide(
                                          color: AppTheme.errorRed.withOpacity(
                                            0.5,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () => _showDeleteAccountDialog(
                                        context,
                                        ref,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.signOut),
        content: Text(AppLocalizations.of(context)!.signOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() => _isLoading = true);
              try {
                await ref.read(authStateProvider.notifier).signOut();
                if (context.mounted) {
                  context.go(AppRoutes.login);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.signOutFailed}$e',
                      ),
                      backgroundColor: AppTheme.errorRed,
                    ),
                  );
                }
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)!.signOut),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteAccount),
        content: Text(AppLocalizations.of(context)!.deleteAccountConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() => _isLoading = true);
              try {
                await ref.read(authStateProvider.notifier).deleteUserAccount();
                if (context.mounted) {
                  context.go(AppRoutes.login);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.accountDeletionFailed}$e',
                      ),
                      backgroundColor: AppTheme.errorRed,
                    ),
                  );
                }
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  void _showClearCredentialsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.clearSavedCredentials),
        content: Text(AppLocalizations.of(context)!.clearCredentialsConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() => _isLoading = true);
              try {
                await ref
                    .read(authStateProvider.notifier)
                    .clearSavedCredentials();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.savedCredentialsCleared,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.clearCredentialsFailed}$e',
                      ),
                      backgroundColor: AppTheme.errorRed,
                    ),
                  );
                }
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGreen,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)!.clear),
          ),
        ],
      ),
    );
  }
}
