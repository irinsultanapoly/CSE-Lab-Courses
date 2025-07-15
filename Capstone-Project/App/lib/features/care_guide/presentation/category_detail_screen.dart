import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../data/models/care_guide_models.dart';
import 'care_guide_detail_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../utils/care_guide_localization.dart';

class CategoryDetailScreen extends ConsumerWidget {
  final CareGuideCategory category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          CareGuideLocalization.getCategoryName(context, category.id),
        ),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Description
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getIconData(category.icon),
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          CareGuideLocalization.getCategoryName(
                            context,
                            category.id,
                          ),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    CareGuideLocalization.getCategoryDescription(
                      context,
                      category.id,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      '${category.guides.length} ${AppLocalizations.of(context)!.guides}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Guides List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  itemCount: category.guides.length,
                  itemBuilder: (context, index) {
                    final guide = category.guides[index];
                    return _buildGuideCard(context, guide);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideCard(BuildContext context, CareGuide guide) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CareGuideDetailScreen(category: category, guide: guide),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Plant Image Placeholder
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGreen.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getPlantIcon(guide.id),
                    color: AppTheme.primaryGreen,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkText,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(
                            guide.difficulty,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          CareGuideLocalization.getDifficultyLevel(
                            context,
                            guide.difficulty,
                          ),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: _getDifficultyColor(guide.difficulty),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 16,
                            color: AppTheme.mediumText,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              guide.light,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppTheme.mediumText),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).iconTheme.color,
                  size: 16,
                ),
              ],
            ),
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'very easy':
        return Colors.green;
      case 'easy':
        return Colors.lightGreen;
      case 'moderate':
        return Colors.orange;
      case 'difficult':
        return Colors.red;
      default:
        return AppTheme.mediumText;
    }
  }
}
