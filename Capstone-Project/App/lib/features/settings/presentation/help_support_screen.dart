import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/screen_title.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
                  ScreenTitle(title: AppLocalizations.of(context)!.helpSupport),
                  const SizedBox(height: 32),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FAQ Section
                          _buildSectionTitle(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.frequentlyAskedQuestions,
                          ),
                          const SizedBox(height: 16),

                          _buildFAQCard(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.howToDetectPlantDiseases,
                            AppLocalizations.of(
                              context,
                            )!.diseaseDetectionAnswer,
                          ),

                          _buildFAQCard(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.howAccurateIsDetection,
                            AppLocalizations.of(
                              context,
                            )!.detectionAccuracyAnswer,
                          ),

                          _buildFAQCard(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.canISaveDetectionHistory,
                            AppLocalizations.of(
                              context,
                            )!.detectionHistoryAnswer,
                          ),

                          _buildFAQCard(
                            context,
                            AppLocalizations.of(context)!.howToGetTreatment,
                            AppLocalizations.of(
                              context,
                            )!.treatmentRecommendationsAnswer,
                          ),

                          const SizedBox(height: 32),

                          // Contact Section
                          _buildSectionTitle(
                            context,
                            AppLocalizations.of(context)!.contactSupport,
                          ),
                          const SizedBox(height: 16),

                          _buildContactCard(
                            context,
                            Icons.email_rounded,
                            AppLocalizations.of(context)!.emailSupport,
                            AppLocalizations.of(context)!.getHelpViaEmail,
                            'support@bagani.app',
                            () => _launchEmail('support@bagani.app'),
                          ),

                          // _buildContactCard(
                          //   context,
                          //   Icons.chat_rounded,
                          //   'Live Chat',
                          //   'Chat with our support team',
                          //   'Available 24/7',
                          //   () => _showComingSoon(context),
                          // ),
                          _buildContactCard(
                            context,
                            Icons.phone_rounded,
                            AppLocalizations.of(context)!.phoneSupport,
                            AppLocalizations.of(context)!.callUsDirectly,
                            '+8801648593538',
                            () => _launchPhone('+8801648593538'),
                          ),

                          // const SizedBox(height: 32),

                          // // Resources Section
                          // _buildSectionTitle(context, 'Resources'),
                          // const SizedBox(height: 16),

                          // _buildResourceCard(
                          //   context,
                          //   Icons.book_rounded,
                          //   'User Guide',
                          //   'Complete guide to using BAGANI',
                          //   () => _showComingSoon(context),
                          // ),

                          // _buildResourceCard(
                          //   context,
                          //   Icons.video_library_rounded,
                          //   'Video Tutorials',
                          //   'Learn with step-by-step videos',
                          //   () => _showComingSoon(context),
                          // ),

                          // _buildResourceCard(
                          //   context,
                          //   Icons.feedback_rounded,
                          //   'Send Feedback',
                          //   'Help us improve BAGANI',
                          //   () => _launchEmail('feedback@bagani.app'),
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

  Widget _buildFAQCard(BuildContext context, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(20),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).cardColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        iconColor: AppTheme.accentGreen,
        collapsedIconColor: AppTheme.accentGreen,
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkText,
          ),
        ),
        children: [
          Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String action,
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
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      action,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.accentGreen,
                        fontWeight: FontWeight.w500,
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

  Widget _buildResourceCard(
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

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=BAGANI Support Request',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.thisFeatureComingSoon),
        backgroundColor: AppTheme.accentGreen,
      ),
    );
  }
}
