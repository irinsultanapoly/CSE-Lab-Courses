import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/screen_title.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../../../l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ScreenTitle(title: AppLocalizations.of(context)!.about),
                  const SizedBox(height: 32),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App Info Section
                          _buildSectionTitle(
                            context,
                            AppLocalizations.of(context)!.appInformation,
                          ),
                          const SizedBox(height: 16),

                          _buildInfoCard(
                            context,
                            Icons.info_rounded,
                            AppLocalizations.of(context)!.appName,
                            AppConstants.appName,
                          ),

                          _buildInfoCard(
                            context,
                            Icons.description_rounded,
                            AppLocalizations.of(context)!.description,
                            AppConstants.appDescription,
                          ),

                          if (_packageInfo != null) ...[
                            _buildInfoCard(
                              context,
                              Icons.tag_rounded,
                              AppLocalizations.of(context)!.version,
                              '${_packageInfo!.version} (${_packageInfo!.buildNumber})',
                            ),

                            _buildInfoCard(
                              context,
                              Icons.inventory_rounded,
                              AppLocalizations.of(context)!.packageName,
                              _packageInfo!.packageName,
                            ),
                          ],

                          const SizedBox(height: 32),

                          // Features Section
                          _buildSectionTitle(
                            context,
                            AppLocalizations.of(context)!.features,
                          ),
                          const SizedBox(height: 16),

                          _buildFeatureCard(
                            context,
                            Icons.camera_alt_rounded,
                            AppLocalizations.of(context)!.aiDiseaseDetection,
                            AppLocalizations.of(
                              context,
                            )!.aiDiseaseDetectionDesc,
                          ),

                          _buildFeatureCard(
                            context,
                            Icons.healing_rounded,
                            AppLocalizations.of(
                              context,
                            )!.treatmentRecommendations,
                            AppLocalizations.of(
                              context,
                            )!.treatmentRecommendationsDesc,
                          ),

                          _buildFeatureCard(
                            context,
                            Icons.history_rounded,
                            AppLocalizations.of(context)!.detectionHistory,
                            AppLocalizations.of(context)!.detectionHistoryDesc,
                          ),

                          _buildFeatureCard(
                            context,
                            Icons.book_rounded,
                            AppLocalizations.of(context)!.careGuides,
                            AppLocalizations.of(context)!.careGuidesDesc,
                          ),

                          // const SizedBox(height: 32),

                          // // Technology Section
                          // _buildSectionTitle(context, 'Technology'),
                          // const SizedBox(height: 16),

                          // _buildTechCard(
                          //   context,
                          //   Icons.psychology_rounded,
                          //   'Machine Learning',
                          //   'TensorFlow Lite for on-device AI processing',
                          // ),

                          // _buildTechCard(
                          //   context,
                          //   Icons.cloud_rounded,
                          //   'Cloud Integration',
                          //   'Firebase for secure data storage and authentication',
                          // ),

                          // _buildTechCard(
                          //   context,
                          //   Icons.security_rounded,
                          //   'Privacy First',
                          //   'Your data stays on your device, we respect your privacy',
                          // ),

                          // const SizedBox(height: 32),

                          // // Team Section
                          // _buildSectionTitle(context, 'Development Team'),
                          // const SizedBox(height: 16),

                          // _buildTeamCard(
                          //   context,
                          //   Icons.person_rounded,
                          //   'Lead Developer',
                          //   'Flutter & AI Specialist',
                          // ),

                          // _buildTeamCard(
                          //   context,
                          //   Icons.eco_rounded,
                          //   'Plant Expert',
                          //   'Botanical Consultant',
                          // ),

                          // _buildTeamCard(
                          //   context,
                          //   Icons.design_services_rounded,
                          //   'UI/UX Designer',
                          //   'User Experience Specialist',
                          // ),

                          // const SizedBox(height: 32),

                          // // Legal Section
                          // _buildSectionTitle(context, 'Legal'),
                          // const SizedBox(height: 16),

                          // _buildLegalCard(
                          //   context,
                          //   Icons.privacy_tip_rounded,
                          //   'Privacy Policy',
                          //   'How we protect your data',
                          //   () => _showComingSoon(context),
                          // ),

                          // _buildLegalCard(
                          //   context,
                          //   Icons.description_rounded,
                          //   'Terms of Service',
                          //   'App usage terms and conditions',
                          //   () => _showComingSoon(context),
                          // ),

                          // _buildLegalCard(
                          //   context,
                          //   Icons.gavel_rounded,
                          //   'Licenses',
                          //   'Open source licenses',
                          //   () => _showLicenses(context),
                          // ),
                          const SizedBox(
                            height: 100,
                          ), // Bottom padding for nav bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CustomBackButton(),
        ],
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

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.accentGreen, size: 24),
            ),
            const SizedBox(width: 16),
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
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.accentGreen, size: 24),
            ),
            const SizedBox(width: 16),
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
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.accentGreen, size: 24),
            ),
            const SizedBox(width: 16),
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
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(
    BuildContext context,
    IconData icon,
    String title,
    String role,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.accentGreen, size: 24),
            ),
            const SizedBox(width: 16),
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
                    role,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.accentGreen, size: 24),
              ),
              const SizedBox(width: 16),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppTheme.lightText,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.thisFeatureComingSoon),
        backgroundColor: AppTheme.accentGreen,
      ),
    );
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: _packageInfo?.version ?? '1.0.0',
      applicationIcon: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.accentGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.eco_rounded, size: 48, color: AppTheme.accentGreen),
      ),
    );
  }
}
