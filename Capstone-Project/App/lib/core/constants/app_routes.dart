class AppRoutes {
  // Shell routes for bottom navigation
  static const String shell = '/';
  static const String home = '/home';
  static const String detectionHistory = '/detection-history';
  static const String careGuide = '/care-guide';
  static const String settings = '/settings';

  // Feature routes (pushed on top of shell)
  static const String plantScanning = '/plant-scanning';
  static const String predictionResult = '/prediction-result';
  static const String detectionDetail = '/detection-detail';
  static const String careGuideCategory = '/care-guide-category';
  static const String careGuideDetail = '/care-guide-detail';

  // Settings routes
  static const String languageSelection = '/language-selection';
  static const String themeSelection = '/theme-selection';
  static const String helpSupport = '/help-support';
  static const String about = '/about';

  // Authentication routes
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
}

class AppConstants {
  static const String appName = 'BAGANI';
  static const String appDescription =
      'AI-Powered Plant Care Mobile Application';

  // Assets
  static const String imagesPath = 'assets/images/';
  static const String animationsPath = 'assets/animations/';
  static const String modelsPath = 'assets/models/';

  // Network
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Database
  static const String databaseName = 'bagani.db';
  static const int databaseVersion = 1;
}
