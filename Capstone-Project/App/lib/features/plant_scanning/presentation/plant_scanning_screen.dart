import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bagani/services/plant_classifier_service.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_routes.dart';
import '../../detection_history/domain/detection_history_provider.dart';
import '../../detection_history/data/models/detection_record.dart';
import '../../../core/constants/disease_names.dart';
import '../../../services/plant_disease_service.dart';
import '../../../l10n/app_localizations.dart';

class PlantScanningScreen extends ConsumerStatefulWidget {
  const PlantScanningScreen({super.key});

  @override
  ConsumerState<PlantScanningScreen> createState() =>
      _PlantScanningScreenState();
}

class _PlantScanningScreenState extends ConsumerState<PlantScanningScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  final PlantClassifierService _classifier = PlantClassifierService();
  List<String>? _classLabels;

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  Future<void> _loadLabels() async {
    final labelsString = await rootBundle.loadString(
      'assets/models/labels.txt',
    );
    setState(() {
      _classLabels = labelsString
          .split('\n')
          .where((l) => l.trim().isNotEmpty)
          .toList();
    });
  }

  @override
  void dispose() {
    _classifier.close();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 90);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null || _classLabels == null) return;

    // Show better loading dialog with plant detection theme
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.psychology_alt_rounded,
                  size: 32,
                  color: AppTheme.accentGreen,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.analyzingPlant,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.detectingDiseases,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.mediumText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentGreen),
              ),
            ],
          ),
        ),
      ),
    );

    String? result;
    double confidence = 0.0;

    try {
      // Run prediction quickly
      final output = await _classifier.predict(_selectedImage!);
      final maxIdx = output.indexWhere(
        (e) => e == output.reduce((a, b) => a > b ? a : b),
      );
      result = _classLabels![maxIdx];
      confidence = output[maxIdx];

      // Save detection record to database (this can be done in background)
      _saveDetectionRecord(result!, confidence);
    } catch (e) {
      result = 'Prediction failed: $e';
    }

    if (mounted) Navigator.of(context).pop(); // Remove progress dialog
    if (mounted) {
      // Navigate to prediction result using GoRouter
      context.push(
        '${AppRoutes.predictionResult}/${Uri.encodeComponent(result!)}/${confidence.toStringAsFixed(3)}',
        extra: _selectedImage!.path,
      );
    }
  }

  Future<void> _saveDetectionRecord(String result, double confidence) async {
    try {
      final friendlyName = kHumanFriendlyDiseaseNames[result] ?? result;
      final isHealthy = friendlyName.toLowerCase().contains('healthy');

      // Get AI suggestion for diseased plants
      String? aiSuggestion;
      if (!isHealthy) {
        try {
          final service = PlantDiseaseService();
          final suggestion = await service.getCureSuggestionsFromDiseaseName(
            friendlyName,
          );
          if (suggestion != null) {
            // Clean up the suggestion data and store as proper JSON
            aiSuggestion = _formatAISuggestionForStorage(suggestion);
          }
        } catch (e) {
          // If AI suggestion fails, continue without it
          print('Failed to get AI suggestion: $e');
        }
      }

      final record = DetectionRecord(
        plantName: _extractPlantName(result),
        diseaseName: friendlyName,
        confidence: confidence,
        imagePath: _selectedImage!.path,
        aiSuggestion: aiSuggestion,
        detectedAt: DateTime.now(),
        isHealthy: isHealthy,
      );

      // Save to database using the notifier
      await ref
          .read(detectionHistoryNotifierProvider.notifier)
          .addDetectionRecord(record);
    } catch (e) {
      // Log error but don't show to user to avoid disrupting the flow
      print('Failed to save detection record: $e');
    }
  }

  String _extractPlantName(String result) {
    // Extract plant name from the result string
    // Example: "Apple___Apple_scab" -> "Apple"
    if (result.contains('___')) {
      return result.split('___')[0];
    }
    return result;
  }

  String _formatAISuggestionForStorage(Map<String, dynamic> suggestion) {
    // Clean up the suggestion data and format it properly for storage
    final Map<String, dynamic> cleanedSuggestion = {};

    // Clean title
    if (suggestion['title'] != null) {
      cleanedSuggestion['title'] = _cleanMarkdownText(
        suggestion['title'].toString(),
      );
    }

    // Clean steps
    if (suggestion['steps'] != null) {
      final steps = suggestion['steps'] as List;
      cleanedSuggestion['steps'] = steps
          .map((step) => _cleanMarkdownText(step.toString()))
          .toList();
    }

    // Clean tips
    if (suggestion['tips'] != null) {
      final tips = suggestion['tips'] as List;
      cleanedSuggestion['tips'] = tips
          .map((tip) => _cleanMarkdownText(tip.toString()))
          .toList();
    }

    // Convert to proper JSON string for storage
    final jsonString = jsonEncode(cleanedSuggestion);
    print('Storing AI suggestion as JSON: $jsonString'); // Debug log
    return jsonString;
  }

  String _cleanMarkdownText(String text) {
    // Remove markdown formatting like **, *, etc.
    return text
        .replaceAll('**', '') // Remove bold
        .replaceAll('*', '') // Remove italic
        .replaceAll('__', '') // Remove underline
        .replaceAll('`', '') // Remove code
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: _classLabels == null
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 32),
                            if (_selectedImage == null) ...[
                              Container(
                                padding: const EdgeInsets.all(36),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentGreen.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.accentGreen.withOpacity(
                                        0.08,
                                      ),
                                      blurRadius: 32,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 64,
                                  color: AppTheme.accentGreen,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                AppLocalizations.of(context)!.scanYourPlant,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.primaryGreen,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.takePhotoDescription,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: AppTheme.mediumText),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 48),
                              ElevatedButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera),
                                icon: const Icon(Icons.camera_alt_rounded),
                                label: Text(
                                  AppLocalizations.of(context)!.takePhoto,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.accentGreen,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 18,
                                  ),
                                  minimumSize: const Size(220, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                  elevation: 0,
                                ),
                              ),
                              const SizedBox(height: 16),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                icon: const Icon(Icons.photo_library_rounded),
                                label: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.chooseFromGallery,
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.primaryGreen,
                                  side: BorderSide(
                                    color: AppTheme.primaryGreen,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 18,
                                  ),
                                  minimumSize: const Size(220, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ] else ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  _selectedImage!,
                                  width: 260,
                                  height: 260,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 24),
                              if (_isAnalyzing)
                                const CircularProgressIndicator()
                              else
                                ElevatedButton.icon(
                                  onPressed: _analyzeImage,
                                  icon: const Icon(Icons.science_rounded),
                                  label: Text(
                                    AppLocalizations.of(context)!.analyze,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 36,
                                      vertical: 18,
                                    ),
                                    minimumSize: const Size(180, 52),
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
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () =>
                                    setState(() => _selectedImage = null),
                                icon: const Icon(Icons.close_rounded),
                                label: Text(
                                  AppLocalizations.of(context)!.removeImage,
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: AppTheme.lightGreen.withOpacity(0.13),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.lightbulb_rounded,
                                    color: AppTheme.warningOrange,
                                    size: 26,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.tipsForBetterScanning,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.darkText,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    AppLocalizations.of(context)!.scanningTips,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: AppTheme.mediumText),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          // Modern floating back button
          Positioned(
            top: 24,
            left: 16,
            child: SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
