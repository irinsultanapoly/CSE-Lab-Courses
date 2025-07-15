import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../../../shared/widgets/common_widgets.dart' as shared;
import '../domain/detection_history_provider.dart';
import '../data/models/detection_record.dart';
import '../../../l10n/app_localizations.dart';

class DetectionHistoryScreen extends ConsumerWidget {
  const DetectionHistoryScreen({super.key});
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
                AppLocalizations.of(context)!.detectionHistory,
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
                    final detectionHistoryAsync = ref.watch(
                      detectionHistoryNotifierProvider,
                    );

                    return detectionHistoryAsync.when(
                      data: (records) {
                        if (records.isEmpty) {
                          return _buildEmptyState(context);
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            await ref.refresh(detectionHistoryNotifierProvider);
                          },
                          child: _buildDetectionHistoryList(
                            context,
                            ref,
                            records,
                          ),
                        );
                      },
                      loading: () => Center(
                        child: shared.LoadingWidget(
                          message: AppLocalizations.of(
                            context,
                          )!.loadingDetectionHistory,
                        ),
                      ),
                      error: (error, stackTrace) => shared.ErrorWidget(
                        message: AppLocalizations.of(
                          context,
                        )!.failedToLoadDetectionHistory,
                        onRetry: () =>
                            ref.refresh(detectionHistoryNotifierProvider),
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.history_rounded, size: 64, color: AppTheme.accentGreen),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.noDetectionHistory,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.darkText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.noDetectionHistoryDescription,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.mediumText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetectionHistoryList(
    BuildContext context,
    WidgetRef ref,
    List<DetectionRecord> records,
  ) {
    return Column(
      children: [
        // Statistics Section
        Container(
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
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ref.refresh(detectionStatisticsProvider);
                      ref.refresh(detectionHistoryNotifierProvider);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: 'Refresh',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, child) {
                  final statsAsync = ref.watch(detectionStatisticsProvider);
                  return statsAsync.when(
                    data: (stats) => Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            AppLocalizations.of(context)!.total,
                            '${stats['totalRecords']}',
                            Icons.analytics_rounded,
                            AppTheme.primaryGreen,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            AppLocalizations.of(context)!.healthy,
                            '${stats['healthyRecords']}',
                            Icons.check_circle_rounded,
                            Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            AppLocalizations.of(context)!.diseased,
                            '${stats['diseasedRecords']}',
                            Icons.warning_rounded,
                            AppTheme.errorRed,
                          ),
                        ),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Text(AppLocalizations.of(context)!.errorLoadingStats),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Records List
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return _buildDetectionRecordCard(context, ref, record);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.mediumText),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionRecordCard(
    BuildContext context,
    WidgetRef ref,
    DetectionRecord record,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            // Navigate to detection detail using GoRouter
            context.push(
              '${AppRoutes.detectionDetail}/${record.id}',
              extra: record,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Plant Image Placeholder
                Container(
                  width: 60,
                  height: 60,
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
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkText,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.diseaseName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.mediumText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${(record.confidence * 100).toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(context, record.detectedAt),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.lightText),
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
