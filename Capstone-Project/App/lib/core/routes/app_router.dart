import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/detection_history/presentation/detection_history_screen.dart';
import '../../features/detection_history/presentation/detection_detail_screen.dart';
import '../../features/detection_history/data/models/detection_record.dart';
import '../../features/care_guide/presentation/care_guide_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/plant_scanning/presentation/plant_scanning_screen.dart';
import '../../features/plant_scanning/presentation/prediction_result_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/domain/auth_provider.dart';
import '../../features/settings/presentation/language_selection_screen.dart';
import '../../features/settings/presentation/theme_selection_screen.dart';
import '../../features/settings/presentation/help_support_screen.dart';
import '../../features/settings/presentation/about_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../core/logger/app_logger.dart';
import '../../shared/widgets/shell_scaffold.dart';
import '../constants/app_routes.dart';

final log = AppLogger();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signUp ||
          state.matchedLocation == AppRoutes.forgotPassword;

      // If not authenticated and not on auth route, redirect to login
      if (!isAuthenticated && !isAuthRoute) {
        return AppRoutes.login;
      }

      // If authenticated and on auth route, redirect to home
      if (isAuthenticated && isAuthRoute) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ShellScaffold(location: state.uri.toString(), child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.detectionHistory,
            name: 'detection-history',
            builder: (context, state) => const DetectionHistoryScreen(),
          ),
          GoRoute(
            path: AppRoutes.careGuide,
            name: 'care-guide',
            builder: (context, state) => const CareGuideScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // Feature routes (pushed on top of shell)
      GoRoute(
        path: AppRoutes.plantScanning,
        name: 'plant-scanning',
        builder: (context, state) => const PlantScanningScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.predictionResult}/:result/:confidence',
        name: 'prediction-result',
        builder: (context, state) {
          final result = state.pathParameters['result']!;
          final confidence =
              double.tryParse(state.pathParameters['confidence']!) ?? 0.0;
          final imagePath = state.extra as String?;
          if (imagePath != null) {
            return PredictionResultScreen(
              result: result,
              image: File(imagePath),
              confidence: confidence,
            );
          }
          return const Scaffold(body: Center(child: Text('Image not found')));
        },
      ),
      GoRoute(
        path: '${AppRoutes.detectionDetail}/:id',
        name: 'detection-detail',
        builder: (context, state) {
          final record = state.extra as DetectionRecord?;
          if (record != null) {
            return DetectionDetailScreen(record: record);
          }
          return const Scaffold(body: Center(child: Text('Record not found')));
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          AppLogger.i('Navigating to ProfileScreen');
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),

      // Settings routes
      GoRoute(
        path: AppRoutes.languageSelection,
        name: 'language-selection',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.themeSelection,
        name: 'theme-selection',
        builder: (context, state) => const ThemeSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.helpSupport,
        name: 'help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),

      // Authentication routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
