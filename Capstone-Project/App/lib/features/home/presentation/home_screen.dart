import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../../detection_history/domain/detection_history_provider.dart';
import '../../detection_history/data/models/detection_record.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryGreen,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.yourAiCompanion,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppTheme.mediumText),
                ),
                const SizedBox(height: 32),

                // Main Action Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentGreen.withOpacity(0.08),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGreen.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 48,
                          color: AppTheme.accentGreen,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.scanYourPlant,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGreen,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.aiPoweredIdentification,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.mediumText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.plantScanning),
                        icon: const Icon(Icons.camera_alt_rounded),
                        label: Text(
                          AppLocalizations.of(context)!.startScanningButton,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _QuickActionIcon(
                      icon: Icons.history_rounded,
                      label: AppLocalizations.of(context)!.history,
                      color: AppTheme.primaryGreen,
                      onTap: () => context.go(AppRoutes.detectionHistory),
                    ),
                    _QuickActionIcon(
                      icon: Icons.book_rounded,
                      label: AppLocalizations.of(context)!.careGuide,
                      color: AppTheme.lightGreen,
                      onTap: () => context.go(AppRoutes.careGuide),
                    ),
                    _QuickActionIcon(
                      icon: Icons.settings_rounded,
                      label: AppLocalizations.of(context)!.settings,
                      color: AppTheme.warningOrange,
                      onTap: () => context.go(AppRoutes.settings),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Stats Card
                Consumer(
                  builder: (context, ref, child) {
                    final detectionHistoryAsync = ref.watch(
                      detectionHistoryNotifierProvider,
                    );

                    return detectionHistoryAsync.when(
                      data: (records) {
                        final stats = _calculateStats(records);

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 28,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.yourPlants,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.darkText,
                                        ),
                                  ),
                                  if (records.isNotEmpty)
                                    TextButton(
                                      onPressed: () => context.go(
                                        AppRoutes.detectionHistory,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.viewAll,
                                        style: TextStyle(
                                          color: AppTheme.accentGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ModernStatCard(
                                      icon: Icons.eco_rounded,
                                      value: '${stats['totalRecords']}',
                                      label: AppLocalizations.of(
                                        context,
                                      )!.plants,
                                      color: AppTheme.accentGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _ModernStatCard(
                                      icon: Icons.health_and_safety_rounded,
                                      value: '${stats['healthyRecords']}',
                                      label: AppLocalizations.of(
                                        context,
                                      )!.healthy,
                                      color: AppTheme.lightGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _ModernStatCard(
                                      icon: Icons.warning_rounded,
                                      value: '${stats['diseasedRecords']}',
                                      label: AppLocalizations.of(
                                        context,
                                      )!.needCare,
                                      color: AppTheme.warningOrange,
                                    ),
                                  ),
                                ],
                              ),
                              if (records.isNotEmpty) ...[
                                const SizedBox(height: 24),
                                _buildRecentPlantsList(
                                  context,
                                  records.take(3).toList(),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                      loading: () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 28,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.yourPlants,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.darkText,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                      error: (error, stackTrace) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 28,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.yourPlants,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.darkText,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline_rounded,
                                    color: AppTheme.errorRed,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.failedToLoadData,
                                    style: TextStyle(color: AppTheme.errorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, int> _calculateStats(List<DetectionRecord> records) {
    final totalRecords = records.length;
    final healthyRecords = records.where((record) => record.isHealthy).length;
    final diseasedRecords = totalRecords - healthyRecords;

    return {
      'totalRecords': totalRecords,
      'healthyRecords': healthyRecords,
      'diseasedRecords': diseasedRecords,
    };
  }

  Widget _buildRecentPlantsList(
    BuildContext context,
    List<DetectionRecord> records,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.recentDetections,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkText,
          ),
        ),
        const SizedBox(height: 12),
        ...records
            .map((record) => _buildRecentPlantItem(context, record))
            .toList(),
      ],
    );
  }

  Widget _buildRecentPlantItem(BuildContext context, DetectionRecord record) {
    return InkWell(
      onTap: () => context.push('${AppRoutes.detectionDetail}/${record.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: record.isHealthy
                    ? Colors.green.withOpacity(0.1)
                    : AppTheme.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                record.isHealthy
                    ? Icons.check_circle_rounded
                    : Icons.warning_rounded,
                color: record.isHealthy ? Colors.green : AppTheme.errorRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.plantName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.diseaseName,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.mediumText),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${(record.confidence * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.accentGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(context, record.detectedAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightText,
                        ),
                      ),
                    ],
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
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return AppLocalizations.of(context)!.today;
    } else if (difference.inDays == 1) {
      return AppLocalizations.of(context)!.yesterday;
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

// Minimal quick action icon button
class _QuickActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final double bgOpacity = color == AppTheme.lightGreen ? 0.22 : 0.10;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(bgOpacity),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.mediumText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ModernFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final bool highlight;

  const _ModernFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: highlight
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.darkText,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
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
    );
  }
}

class _ModernStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _ModernStatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double bgOpacity = color == AppTheme.lightGreen ? 0.18 : 0.08;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(bgOpacity),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.darkText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.mediumText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
