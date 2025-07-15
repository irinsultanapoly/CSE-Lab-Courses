import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class CareGuideLocalization {
  static String getCategoryName(BuildContext context, String categoryId) {
    switch (categoryId) {
      case 'houseplants':
        return AppLocalizations.of(context)!.houseplants;
      case 'vegetables':
        return AppLocalizations.of(context)!.vegetables;
      case 'flowers':
        return AppLocalizations.of(context)!.flowers;
      default:
        return categoryId;
    }
  }

  static String getCategoryDescription(
    BuildContext context,
    String categoryId,
  ) {
    switch (categoryId) {
      case 'houseplants':
        return AppLocalizations.of(context)!.houseplantsDescription;
      case 'vegetables':
        return AppLocalizations.of(context)!.vegetablesDescription;
      case 'flowers':
        return AppLocalizations.of(context)!.flowersDescription;
      default:
        return '';
    }
  }

  static String getDifficultyLevel(BuildContext context, String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'very easy':
        return AppLocalizations.of(context)!.veryEasy;
      case 'easy':
        return AppLocalizations.of(context)!.easy;
      case 'moderate':
        return AppLocalizations.of(context)!.moderate;
      case 'difficult':
        return AppLocalizations.of(context)!.difficult;
      default:
        return difficulty;
    }
  }
}
