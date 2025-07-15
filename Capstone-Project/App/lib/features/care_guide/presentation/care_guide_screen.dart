import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/common_widgets.dart' as shared;
import '../domain/care_guide_provider.dart';
import '../data/models/care_guide_models.dart';
import 'category_detail_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../utils/care_guide_localization.dart';

class CareGuideScreen extends ConsumerWidget {
  const CareGuideScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                AppLocalizations.of(context)!.careGuide,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),

              const SizedBox(height: 40),

              // Content
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final categoriesAsync = ref.watch(
                      careGuideCategoriesProvider,
                    );

                    return categoriesAsync.when(
                      data: (categories) => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quick Tips Section
                            _buildSectionTitle(
                              context,
                              AppLocalizations.of(context)!.quickCareTips,
                            ),
                            const SizedBox(height: 16),
                            _buildCareCard(
                              context,
                              Icons.water_drop_rounded,
                              AppLocalizations.of(context)!.watering,
                              AppLocalizations.of(context)!.wateringDescription,
                              AppTheme.accentGreen,
                            ),
                            const SizedBox(height: 12),
                            _buildCareCard(
                              context,
                              Icons.wb_sunny_rounded,
                              AppLocalizations.of(context)!.sunlight,
                              AppLocalizations.of(context)!.sunlightDescription,
                              AppTheme.warningOrange,
                            ),
                            const SizedBox(height: 12),
                            _buildCareCard(
                              context,
                              Icons.thermostat_rounded,
                              AppLocalizations.of(context)!.temperature,
                              AppLocalizations.of(
                                context,
                              )!.temperatureDescription,
                              AppTheme.primaryGreen,
                            ),

                            const SizedBox(height: 32),

                            // Plant Categories
                            _buildSectionTitle(
                              context,
                              AppLocalizations.of(context)!.plantCategories,
                            ),
                            const SizedBox(height: 16),
                            ...categories.map(
                              (category) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildCategoryCard(context, category),
                              ),
                            ),

                            const SizedBox(
                              height: 100,
                            ), // Bottom padding for nav bar
                          ],
                        ),
                      ),
                      loading: () => Center(
                        child: shared.LoadingWidget(
                          message: AppLocalizations.of(
                            context,
                          )!.loadingCareGuides,
                        ),
                      ),
                      error: (error, stackTrace) => shared.ErrorWidget(
                        message: AppLocalizations.of(
                          context,
                        )!.failedToLoadCareGuides,
                        onRetry: () => ref.refresh(careGuidesProvider),
                      ),
                    );
                  },
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

  Widget _buildCareCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
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
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
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
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.mediumText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CareGuideCategory category) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(category: category),
              ),
            );
          },
          child: Row(
            children: [
              Icon(
                _getIconData(category.icon),
                color: AppTheme.accentGreen,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CareGuideLocalization.getCategoryName(context, category.id),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CareGuideLocalization.getCategoryDescription(context, category.id),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.mediumText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home_rounded':
        return Icons.home_rounded;
      case 'eco_rounded':
        return Icons.eco_rounded;
      case 'local_florist_rounded':
        return Icons.local_florist_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
