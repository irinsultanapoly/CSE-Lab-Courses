import 'package:flutter/material.dart';

class AppColors {
  static const seed = Color(0xFF031716);
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.seed,
  ),
);
