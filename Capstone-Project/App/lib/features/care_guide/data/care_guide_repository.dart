import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/logger/app_logger.dart';
import 'models/care_guide_models.dart';

class CareGuideRepository {
  static const String _assetPath = 'assets/care_guides.json';

  Future<CareGuidesData> loadCareGuides() async {
    try {
      AppLogger.i('Loading care guides from $_assetPath');

      final String jsonString = await rootBundle.loadString(_assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final careGuidesData = CareGuidesData.fromJson(jsonData);

      AppLogger.i(
        'Successfully loaded ${careGuidesData.categories.length} care guide categories',
      );

      return careGuidesData;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load care guides: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<CareGuideCategory?> getCategoryById(String categoryId) async {
    try {
      final careGuidesData = await loadCareGuides();
      return careGuidesData.categories.firstWhere(
        (category) => category.id == categoryId,
      );
    } catch (e) {
      AppLogger.e('Failed to get category by ID $categoryId: $e');
      return null;
    }
  }

  Future<CareGuide?> getGuideById(String categoryId, String guideId) async {
    try {
      final category = await getCategoryById(categoryId);
      if (category == null) return null;

      return category.guides.firstWhere((guide) => guide.id == guideId);
    } catch (e) {
      AppLogger.e(
        'Failed to get guide by ID $guideId in category $categoryId: $e',
      );
      return null;
    }
  }
}
