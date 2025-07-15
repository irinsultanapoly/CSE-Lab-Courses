import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/disease_names.dart';
import '../../../core/constants/app_routes.dart';
import '../../../services/plant_disease_service.dart';
import '../../../l10n/app_localizations.dart';

class PredictionResultScreen extends StatefulWidget {
  final String result;
  final File image;
  final double confidence;
  const PredictionResultScreen({
    super.key,
    required this.result,
    required this.image,
    this.confidence = 0.0,
  });

  @override
  State<PredictionResultScreen> createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<PredictionResultScreen> {
  String? _cureSuggestionRaw;
  Map<String, dynamic>? _cureSuggestionJson;
  bool _isLoadingCure = false;
  String? _cureError;

  Future<void> _getCureSuggestionGemini() async {
    setState(() {
      _isLoadingCure = true;
      _cureError = null;
      _cureSuggestionRaw = null;
      _cureSuggestionJson = null;
    });
    final service = PlantDiseaseService();
    try {
      final friendly =
          kHumanFriendlyDiseaseNames[widget.result] ?? widget.result;
      final suggestion = await service.getCureSuggestionsFromDiseaseName(
        friendly,
      );
      if (suggestion != null) {
        setState(() {
          _cureSuggestionJson = suggestion;
        });
      } else {
        setState(() {
          _cureSuggestionRaw = AppLocalizations.of(
            context,
          )!.noStructuredCureSuggestion;
        });
      }
    } catch (e) {
      setState(() {
        _cureError = AppLocalizations.of(
          context,
        )!.failedToFetchSuggestion(e.toString());
      });
    } finally {
      setState(() {
        _isLoadingCure = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendly = kHumanFriendlyDiseaseNames[widget.result] ?? widget.result;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    Material(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      elevation: 3,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          // Navigate to detection history instead of just popping
                          context.go(AppRoutes.detectionHistory);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.predictionResult,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primaryGreen,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                // The rest of the content should be scrollable
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            widget.image,
                            width: 220,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          AppLocalizations.of(context)!.prediction,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.primaryGreen,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          friendly,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkText,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.result,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppTheme.mediumText,
                                fontStyle: FontStyle.italic,
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
                            color: AppTheme.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.confidence(
                              (widget.confidence * 100).toStringAsFixed(1),
                            ),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Cure suggestion section
                        if (_isLoadingCure)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: LinearProgressIndicator(),
                          )
                        else if (_cureSuggestionJson != null)
                          _buildCureSuggestionCard(_cureSuggestionJson!)
                        else if (_cureSuggestionRaw != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              _cureSuggestionRaw!,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        else if (_cureError != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              _cureError!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        // Placeholder for more details (e.g., confidence, description)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.lightGreen.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: AppTheme.primaryGreen,
                                size: 28,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.forBestResults,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppTheme.mediumText),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: (_cureSuggestionJson != null)
                              ? const SizedBox.shrink() // Hide button if tips shown
                              : ElevatedButton.icon(
                                  onPressed: _isLoadingCure
                                      ? null
                                      : _getCureSuggestionGemini,
                                  icon: const Icon(
                                    Icons.psychology_alt_rounded,
                                  ),
                                  label: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.getSolutionFromAi,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.accentGreen,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCureSuggestionCard(Map<String, dynamic> json) {
    final title =
        (json['title'] as String?)?.replaceAll('*', '').trim() ??
        AppLocalizations.of(context)!.cureSuggestion;
    final steps =
        (json['steps'] as List?)
            ?.map((s) => (s as String).replaceAll('*', '').trim())
            .toList() ??
        [];
    final tips =
        (json['tips'] as List?)
            ?.map((t) => (t as String).replaceAll('*', '').trim())
            .toList() ??
        [];
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
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          if (steps.isNotEmpty) ...[
            Text(
              AppLocalizations.of(context)!.steps,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ...steps.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(child: Text(s)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (tips.isNotEmpty) ...[
            Text(
              AppLocalizations.of(context)!.tips,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ...tips.map(
              (t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('– ', style: TextStyle(fontSize: 16)),
                    Expanded(child: Text(t)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
