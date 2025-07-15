import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../data/models/care_guide_models.dart';
import '../../../l10n/app_localizations.dart';
import '../utils/care_guide_localization.dart';

class CareGuideDetailScreen extends ConsumerWidget {
  final CareGuideCategory category;
  final CareGuide guide;

  const CareGuideDetailScreen({
    super.key,
    required this.category,
    required this.guide,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(guide.title),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant Image and Basic Info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // Plant Image Placeholder
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _getPlantIcon(guide.id),
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      guide.title,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        CareGuideLocalization.getDifficultyLevel(
                          context,
                          guide.difficulty,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Care Requirements
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(
                      context,
                      AppLocalizations.of(context)!.careRequirements,
                    ),
                    const SizedBox(height: 16),
                    _buildCareRequirementCard(
                      context,
                      Icons.wb_sunny_rounded,
                      AppLocalizations.of(context)!.light,
                      guide.light,
                      AppTheme.warningOrange,
                    ),
                    const SizedBox(height: 12),
                    _buildCareRequirementCard(
                      context,
                      Icons.water_drop_rounded,
                      AppLocalizations.of(context)!.water,
                      guide.water,
                      AppTheme.accentGreen,
                    ),
                    const SizedBox(height: 12),
                    _buildCareRequirementCard(
                      context,
                      Icons.thermostat_rounded,
                      AppLocalizations.of(context)!.temperature,
                      guide.temperature,
                      AppTheme.primaryGreen,
                    ),
                    const SizedBox(height: 12),
                    _buildCareRequirementCard(
                      context,
                      Icons.opacity_rounded,
                      AppLocalizations.of(context)!.humidity,
                      guide.humidity,
                      Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildCareRequirementCard(
                      context,
                      Icons.eco_rounded,
                      AppLocalizations.of(context)!.soil,
                      guide.soil,
                      Colors.brown,
                    ),
                    const SizedBox(height: 12),
                    _buildCareRequirementCard(
                      context,
                      Icons.grass_rounded,
                      AppLocalizations.of(context)!.fertilizer,
                      guide.fertilizer,
                      Colors.green,
                    ),

                    const SizedBox(height: 32),

                    // Care Tips
                    _buildSectionTitle(
                      context,
                      AppLocalizations.of(context)!.careTips,
                    ),
                    const SizedBox(height: 16),
                    _buildTipsList(context, guide.careTips),

                    const SizedBox(height: 32),

                    // Common Issues
                    _buildSectionTitle(
                      context,
                      AppLocalizations.of(context)!.commonIssues,
                    ),
                    const SizedBox(height: 16),
                    _buildIssuesList(context, guide.commonIssues),

                    const SizedBox(height: 100), // Bottom padding for nav bar
                  ],
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

  Widget _buildCareRequirementCard(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppTheme.mediumText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsList(BuildContext context, List<String> tips) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.accentGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tips[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.darkText,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIssuesList(BuildContext context, List<String> issues) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: issues.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.errorRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.warning_rounded,
                      size: 16,
                      color: AppTheme.errorRed,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    issues[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.darkText,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getPlantIcon(String plantId) {
    switch (plantId) {
      case 'monstera':
        return Icons.eco_rounded;
      case 'snake_plant':
        return Icons.eco_rounded;
      case 'pothos':
        return Icons.eco_rounded;
      case 'ficus':
        return Icons.eco_rounded;
      case 'zz_plant':
        return Icons.eco_rounded;
      case 'tomatoes':
        return Icons.eco_rounded;
      case 'lettuce':
        return Icons.eco_rounded;
      case 'carrots':
        return Icons.eco_rounded;
      case 'peppers':
        return Icons.eco_rounded;
      case 'cucumbers':
        return Icons.eco_rounded;
      case 'roses':
        return Icons.local_florist_rounded;
      case 'sunflowers':
        return Icons.local_florist_rounded;
      case 'marigolds':
        return Icons.local_florist_rounded;
      case 'lavender':
        return Icons.local_florist_rounded;
      case 'zinnias':
        return Icons.local_florist_rounded;
      default:
        return Icons.eco_rounded;
    }
  }
}
