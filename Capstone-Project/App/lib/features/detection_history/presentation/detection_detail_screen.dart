import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';

import '../data/models/detection_record.dart';
import '../domain/detection_history_provider.dart';
import '../../../services/plant_disease_service.dart';
import '../../../l10n/app_localizations.dart';

class DetectionDetailScreen extends ConsumerStatefulWidget {
  final DetectionRecord record;

  const DetectionDetailScreen({super.key, required this.record});

  @override
  ConsumerState<DetectionDetailScreen> createState() =>
      _DetectionDetailScreenState();
}

class _DetectionDetailScreenState extends ConsumerState<DetectionDetailScreen> {
  Map<String, dynamic>? _cureSuggestion;
  bool _isLoadingCure = false;
  String? _cureError;

  @override
  void initState() {
    super.initState();
    _loadCureSuggestion();
  }

  Future<void> _loadCureSuggestion() async {
    if (widget.record.aiSuggestion != null) {
      // If we already have AI suggestion stored, try to parse it
      try {
        String suggestionString = widget.record.aiSuggestion!;
        print('Raw AI suggestion: $suggestionString'); // Debug log

        // Try to parse using the helper method
        final parsedSuggestion = _parseAISuggestion(suggestionString);

        if (parsedSuggestion != null) {
          print('Parsed suggestion: $parsedSuggestion'); // Debug log
          setState(() {
            _cureSuggestion = parsedSuggestion;
          });
          return;
        }

        // If parsing fails, try alternative parsing for different formats
        if (suggestionString.contains('title') ||
            suggestionString.contains('steps') ||
            suggestionString.contains('tips')) {
          // Try to extract information manually
          final Map<String, dynamic> suggestion = {};

          // Simple string-based extraction
          if (suggestionString.contains('title')) {
            final titleStart = suggestionString.indexOf('title');
            final titleEnd = suggestionString.indexOf(',', titleStart);
            if (titleEnd > titleStart) {
              final titlePart = suggestionString.substring(
                titleStart,
                titleEnd,
              );
              final colonIndex = titlePart.indexOf(':');
              if (colonIndex > 0) {
                final title = titlePart
                    .substring(colonIndex + 1)
                    .trim()
                    .replaceAll('"', '')
                    .replaceAll("'", '');
                if (title.isNotEmpty) {
                  suggestion['title'] = title;
                }
              }
            }
          }

          // Extract steps as a simple list
          if (suggestionString.contains('steps')) {
            final stepsStart = suggestionString.indexOf('steps');
            final stepsEnd = suggestionString.indexOf(']', stepsStart);
            if (stepsEnd > stepsStart) {
              final stepsPart = suggestionString.substring(
                stepsStart,
                stepsEnd,
              );
              final bracketStart = stepsPart.indexOf('[');
              if (bracketStart > 0) {
                final stepsContent = stepsPart.substring(bracketStart + 1);
                final steps = stepsContent
                    .split(',')
                    .map(
                      (s) => s.trim().replaceAll('"', '').replaceAll("'", ''),
                    )
                    .where((s) => s.isNotEmpty)
                    .toList();
                if (steps.isNotEmpty) {
                  suggestion['steps'] = steps;
                }
              }
            }
          }

          // Extract tips as a simple list
          if (suggestionString.contains('tips')) {
            final tipsStart = suggestionString.indexOf('tips');
            final tipsEnd = suggestionString.indexOf(']', tipsStart);
            if (tipsEnd > tipsStart) {
              final tipsPart = suggestionString.substring(tipsStart, tipsEnd);
              final bracketStart = tipsPart.indexOf('[');
              if (bracketStart > 0) {
                final tipsContent = tipsPart.substring(bracketStart + 1);
                final tips = tipsContent
                    .split(',')
                    .map(
                      (s) => s.trim().replaceAll('"', '').replaceAll("'", ''),
                    )
                    .where((s) => s.isNotEmpty)
                    .toList();
                if (tips.isNotEmpty) {
                  suggestion['tips'] = tips;
                }
              }
            }
          }

          if (suggestion.isNotEmpty) {
            print('Alternative parsed suggestion: $suggestion'); // Debug log
            setState(() {
              _cureSuggestion = suggestion;
            });
            return;
          }
        }
      } catch (e) {
        // If parsing fails, fetch fresh suggestion
        print('Failed to parse stored AI suggestion: $e');
      }
    }

    // Fetch fresh AI suggestion
    await _fetchCureSuggestion();
  }

  Future<void> _fetchCureSuggestion() async {
    if (widget.record.isHealthy) return; // No cure needed for healthy plants

    setState(() {
      _isLoadingCure = true;
      _cureError = null;
    });

    try {
      final service = PlantDiseaseService();
      final suggestion = await service.getCureSuggestionsFromDiseaseName(
        widget.record.diseaseName,
      );

      if (suggestion != null) {
        setState(() {
          _cureSuggestion = suggestion;
        });
      } else {
        setState(() {
          _cureError = AppLocalizations.of(context)!.noCureSuggestionAvailable;
        });
      }
    } catch (e) {
      setState(() {
        _cureError = AppLocalizations.of(
          context,
        )!.failedToLoadCureSuggestion(e.toString());
      });
    } finally {
      setState(() {
        _isLoadingCure = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detectionDetails),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant Image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: _buildImageWidget(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Detection Result
                    _buildSectionTitle(context, 'Detection Result'),
                    const SizedBox(height: 16),
                    _buildDetectionResultCard(context),

                    const SizedBox(height: 32),

                    // Detection Details
                    _buildSectionTitle(context, 'Detection Details'),
                    const SizedBox(height: 16),
                    _buildDetectionDetailsCard(context),

                    const SizedBox(height: 32),

                    // AI Cure Suggestion (only for diseased plants)
                    if (!widget.record.isHealthy) ...[
                      _buildSectionTitle(context, 'AI Cure Suggestion'),
                      const SizedBox(height: 16),
                      _buildCureSuggestionCard(context),
                      const SizedBox(height: 32),
                    ],

                    // Actions
                    _buildSectionTitle(context, 'Actions'),
                    const SizedBox(height: 16),
                    _buildActionsCard(context),

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

  Widget _buildImageWidget() {
    try {
      final file = File(widget.record.imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
        );
      } else {
        return _buildImagePlaceholder();
      }
    } catch (e) {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_rounded,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'Image not available',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
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

  Widget _buildDetectionResultCard(BuildContext context) {
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.record.isHealthy
                      ? Colors.green.withOpacity(0.1)
                      : AppTheme.errorRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.record.isHealthy
                      ? Icons.check_circle_rounded
                      : Icons.warning_rounded,
                  color: widget.record.isHealthy
                      ? Colors.green
                      : AppTheme.errorRed,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.record.plantName,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkText,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.record.diseaseName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.mediumText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.analytics_rounded,
                  size: 16,
                  color: AppTheme.accentGreen,
                ),
                const SizedBox(width: 8),
                Text(
                  'Confidence: ${(widget.record.confidence * 100).toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.accentGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionDetailsCard(BuildContext context) {
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
      child: Column(
        children: [
          _buildDetailRow('Plant', widget.record.plantName, Icons.eco_rounded),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Disease',
            widget.record.diseaseName,
            Icons.bug_report_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Status',
            widget.record.isHealthy ? 'Healthy' : 'Diseased',
            widget.record.isHealthy
                ? Icons.check_circle_rounded
                : Icons.warning_rounded,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Detected',
            _formatDateTime(widget.record.detectedAt),
            Icons.schedule_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryGreen, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.mediumText),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCureSuggestionCard(BuildContext context) {
    if (_isLoadingCure) {
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
        child: const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading cure suggestion...'),
            ],
          ),
        ),
      );
    }

    if (_cureError != null) {
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
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppTheme.errorRed,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              _cureError!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.errorRed),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchCureSuggestion,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_cureSuggestion == null) {
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
        child: Column(
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              color: AppTheme.warningOrange,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'No cure suggestion available',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.mediumText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _cureSuggestion!['title'] != null
                ? _cleanMarkdownText(_cureSuggestion!['title'].toString())
                : 'Cure Suggestion',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          if (_cureSuggestion!['steps'] != null) ...[
            const Text('Steps:', style: TextStyle(fontWeight: FontWeight.w600)),
            ..._buildStepsList(_cureSuggestion!['steps']),
            const SizedBox(height: 10),
          ],
          if (_cureSuggestion!['tips'] != null) ...[
            const Text('Tips:', style: TextStyle(fontWeight: FontWeight.w600)),
            ..._buildTipsList(_cureSuggestion!['tips']),
          ],
        ],
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context) {
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
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to plant scanning using GoRouter
                context.go(AppRoutes.plantScanning);
              },
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text('Scan Another Plant'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Delete this record
                _showDeleteConfirmation(context);
              },
              icon: const Icon(Icons.delete_rounded),
              label: const Text('Delete Record'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorRed,
                side: BorderSide(color: AppTheme.errorRed),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text(
            'Are you sure you want to delete this detection record? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteRecord();
              },
              style: TextButton.styleFrom(foregroundColor: AppTheme.errorRed),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteRecord() {
    // Delete the record using the notifier
    ref
        .read(detectionHistoryNotifierProvider.notifier)
        .deleteDetectionRecord(widget.record.id!);
    Navigator.of(context).pop();
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago at ${_formatTime(dateTime)}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  List<Widget> _buildStepsList(dynamic steps) {
    if (steps is List) {
      return steps
          .map(
            (s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(_cleanMarkdownText(s.toString()))),
                ],
              ),
            ),
          )
          .toList();
    } else if (steps is String) {
      // If steps is a string, split it by newlines or commas
      final stepList = steps
          .split(RegExp(r'[\n,]+'))
          .where((s) => s.trim().isNotEmpty)
          .toList();
      return stepList
          .map(
            (s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(_cleanMarkdownText(s.trim()))),
                ],
              ),
            ),
          )
          .toList();
    }
    return [];
  }

  List<Widget> _buildTipsList(dynamic tips) {
    if (tips is List) {
      return tips
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('– ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(_cleanMarkdownText(t.toString()))),
                ],
              ),
            ),
          )
          .toList();
    } else if (tips is String) {
      // If tips is a string, split it by newlines or commas
      final tipList = tips
          .split(RegExp(r'[\n,]+'))
          .where((s) => s.trim().isNotEmpty)
          .toList();
      return tipList
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('– ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(_cleanMarkdownText(t.trim()))),
                ],
              ),
            ),
          )
          .toList();
    }
    return [];
  }

  // Helper method to parse AI suggestion string more robustly
  Map<String, dynamic>? _parseAISuggestion(String suggestionString) {
    try {
      // Try to parse as proper JSON first
      if (suggestionString.startsWith('{') && suggestionString.endsWith('}')) {
        try {
          final Map<String, dynamic> suggestion = jsonDecode(suggestionString);
          print(
            'Successfully parsed JSON suggestion: $suggestion',
          ); // Debug log
          return suggestion.isNotEmpty ? suggestion : null;
        } catch (e) {
          print('JSON parsing failed, trying fallback: $e'); // Debug log
        }
      }

      // Fallback to old parsing method for backward compatibility
      suggestionString = suggestionString.trim();

      // Simple JSON-like parsing
      final Map<String, dynamic> suggestion = {};

      // Remove outer braces
      suggestionString = suggestionString.substring(
        1,
        suggestionString.length - 1,
      );

      // Split by commas, but be careful with nested structures
      final pairs = suggestionString.split(',');

      for (String pair in pairs) {
        if (pair.contains(':')) {
          final colonIndex = pair.indexOf(':');
          final key = pair
              .substring(0, colonIndex)
              .trim()
              .replaceAll('"', '')
              .replaceAll("'", '');
          final value = pair.substring(colonIndex + 1).trim();

          // Handle different value types
          if (value.startsWith('[') && value.endsWith(']')) {
            // Array value
            final arrayString = value.substring(1, value.length - 1);
            final items = arrayString
                .split(',')
                .map(
                  (item) => item.trim().replaceAll('"', '').replaceAll("'", ''),
                )
                .where((item) => item.isNotEmpty)
                .toList();
            suggestion[key] = items;
          } else {
            // String value
            suggestion[key] = value.replaceAll('"', '').replaceAll("'", '');
          }
        }
      }

      return suggestion.isNotEmpty ? suggestion : null;
    } catch (e) {
      print('Failed to parse AI suggestion: $e');
    }
    return null;
  }

  // Helper method to clean markdown text
  String _cleanMarkdownText(String text) {
    return text
        .replaceAll('**', '') // Remove bold
        .replaceAll('*', '') // Remove italic
        .replaceAll('__', '') // Remove underline
        .replaceAll('`', '') // Remove code
        .trim();
  }
}
