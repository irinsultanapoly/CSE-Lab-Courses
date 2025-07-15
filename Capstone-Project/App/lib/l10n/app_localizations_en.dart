// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BAGANI';

  @override
  String get home => 'Home';

  @override
  String get detection => 'Detection';

  @override
  String get treatment => 'Treatment';

  @override
  String get profile => 'Profile';

  @override
  String get welcomeMessage => 'Welcome to Plant Care';

  @override
  String get appDescription =>
      'AI-powered disease detection and treatment recommendations';

  @override
  String get detectDisease => 'Detect Disease';

  @override
  String get detectDiseaseDesc => 'Take a photo to identify plant diseases';

  @override
  String get getTreatment => 'Get Treatment';

  @override
  String get getTreatmentDesc => 'AI-powered treatment recommendations';

  @override
  String get plantAnalytics => 'Plant Analytics';

  @override
  String get plantAnalyticsDesc => 'Track your plant health over time';

  @override
  String get plantGuide => 'Plant Guide';

  @override
  String get plantGuideDesc => 'Learn about plant care and diseases';

  @override
  String get yourAiCompanion => 'Your AI Plant Care Companion';

  @override
  String get scanYourPlant => 'Scan Your Plant';

  @override
  String get aiPoweredIdentification =>
      'AI-powered plant disease identification';

  @override
  String get yourPlants => 'Your Plants';

  @override
  String get viewAll => 'View All';

  @override
  String get noRecentScans => 'No Recent Scans';

  @override
  String get startScanning => 'Start scanning your plants to see them here';

  @override
  String get startScanningButton => 'Start Scanning';

  @override
  String get scanNow => 'Scan Now';

  @override
  String get history => 'History';

  @override
  String get careGuide => 'Care Guide';

  @override
  String get settings => 'Settings';

  @override
  String get plants => 'Plants';

  @override
  String get healthy => 'Healthy';

  @override
  String get needCare => 'Need Care';

  @override
  String get recentDetections => 'Recent Detections';

  @override
  String get failedToLoadData => 'Failed to load data';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get quickCareTips => 'Quick Care Tips';

  @override
  String get watering => 'Watering';

  @override
  String get wateringDescription =>
      'Check soil moisture before watering. Most plants prefer slightly dry soil between watering.';

  @override
  String get sunlight => 'Sunlight';

  @override
  String get sunlightDescription =>
      'Place plants near windows for natural light. Rotate weekly for even growth.';

  @override
  String get temperature => 'Temperature';

  @override
  String get temperatureDescription =>
      'Keep plants away from heat sources and cold drafts. Room temperature is usually ideal.';

  @override
  String get plantCategories => 'Plant Categories';

  @override
  String get loadingCareGuides => 'Loading care guides...';

  @override
  String get failedToLoadCareGuides => 'Failed to load care guides';

  @override
  String get guides => 'Guides';

  @override
  String get careRequirements => 'Care Requirements';

  @override
  String get light => 'Light';

  @override
  String get water => 'Water';

  @override
  String get humidity => 'Humidity';

  @override
  String get soil => 'Soil';

  @override
  String get fertilizer => 'Fertilizer';

  @override
  String get careTips => 'Care Tips';

  @override
  String get commonIssues => 'Common Issues';

  @override
  String get houseplants => 'Houseplants';

  @override
  String get houseplantsDescription =>
      'Indoor plants for home decoration and air purification';

  @override
  String get vegetables => 'Vegetables';

  @override
  String get vegetablesDescription =>
      'Edible plants for home gardening and fresh produce';

  @override
  String get flowers => 'Flowers';

  @override
  String get flowersDescription =>
      'Beautiful flowering plants for gardens and decoration';

  @override
  String get veryEasy => 'Very Easy';

  @override
  String get easy => 'Easy';

  @override
  String get moderate => 'Moderate';

  @override
  String get difficult => 'Difficult';

  @override
  String get takePhotoDescription =>
      'Take a photo of your plant to detect diseases and get treatment recommendations';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get analyze => 'Analyze';

  @override
  String get removeImage => 'Remove Image';

  @override
  String get analyzingPlant => 'Analyzing Plant...';

  @override
  String get detectingDiseases => 'Detecting diseases and generating solutions';

  @override
  String get tipsForBetterScanning => 'Tips for better scanning';

  @override
  String get scanningTips =>
      '• Take clear, well-lit photos of a single leaf or plant part\n• Avoid backgrounds with other plants or objects\n• Make sure the diseased area is visible and in focus';

  @override
  String get predictionResult => 'Prediction Result';

  @override
  String get prediction => 'Prediction:';

  @override
  String confidence(String percentage) {
    return 'Confidence: $percentage%';
  }

  @override
  String get getSolutionFromAi => 'Get Solution from AI';

  @override
  String get cureSuggestion => 'Cure Suggestion';

  @override
  String get steps => 'Steps:';

  @override
  String get tips => 'Tips:';

  @override
  String get forBestResults =>
      'For best results, ensure clear images and good lighting. Tap below to get AI-powered solutions for this disease.';

  @override
  String get noStructuredCureSuggestion =>
      'No structured cure suggestion could be generated for this disease.';

  @override
  String failedToFetchSuggestion(String error) {
    return 'Failed to fetch suggestion: $error';
  }

  @override
  String get detectionHistory => 'Detection History';

  @override
  String get loadingDetectionHistory => 'Loading detection history...';

  @override
  String get failedToLoadDetectionHistory => 'Failed to load detection history';

  @override
  String get noDetectionHistory => 'No Detection History';

  @override
  String get noDetectionHistoryDescription =>
      'Your plant disease detection history will appear here once you start scanning plants.';

  @override
  String get total => 'Total';

  @override
  String get diseased => 'Diseased';

  @override
  String get errorLoadingStats => 'Error loading stats';

  @override
  String get detectionDetails => 'Detection Details';

  @override
  String get noCureSuggestionAvailable =>
      'No cure suggestion available for this disease.';

  @override
  String failedToLoadCureSuggestion(String error) {
    return 'Failed to load cure suggestion: $error';
  }

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get signOut => 'Sign Out';

  @override
  String get clearSavedCredentials => 'Clear Saved Credentials';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get processing => 'Processing...';

  @override
  String get signOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.';

  @override
  String get delete => 'Delete';

  @override
  String get clearCredentialsConfirm =>
      'Are you sure you want to clear all saved credentials? You will need to enter them again next time.';

  @override
  String get clear => 'Clear';

  @override
  String get signOutFailed => 'Sign out failed: ';

  @override
  String get accountDeletionFailed => 'Account deletion failed: ';

  @override
  String get clearCredentialsFailed => 'Failed to clear credentials: ';

  @override
  String get savedCredentialsCleared =>
      'Saved credentials cleared successfully';

  @override
  String get updatingLanguage => 'Updating language...';

  @override
  String languageUpdatedTo(String language) {
    return 'Language updated to $language';
  }

  @override
  String failedToUpdateLanguage(String error) {
    return 'Failed to update language: $error';
  }

  @override
  String get updatingTheme => 'Updating theme...';

  @override
  String themeUpdatedTo(String theme) {
    return 'Theme updated to $theme';
  }

  @override
  String failedToUpdateTheme(String error) {
    return 'Failed to update theme: $error';
  }

  @override
  String get followsDeviceSettings => 'Follows your device settings';

  @override
  String get lightThemeDescription => 'Light theme for bright environments';

  @override
  String get darkThemeDescription => 'Dark theme for low-light environments';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions';

  @override
  String get howToDetectPlantDiseases => 'How to detect plant diseases?';

  @override
  String get diseaseDetectionAnswer =>
      'Take a photo of your plant\'s affected area using the camera feature. Our AI will analyze the image and provide disease identification with treatment recommendations.';

  @override
  String get howAccurateIsDetection => 'How accurate is the disease detection?';

  @override
  String get detectionAccuracyAnswer =>
      'Our AI model has been trained on thousands of plant disease images and achieves high accuracy. However, for critical cases, we recommend consulting with a plant expert.';

  @override
  String get canISaveDetectionHistory => 'Can I save my detection history?';

  @override
  String get detectionHistoryAnswer =>
      'Yes! All your detections are automatically saved and can be accessed from the Detection History tab. You can view past results and treatment recommendations.';

  @override
  String get howToGetTreatment => 'How to get treatment recommendations?';

  @override
  String get treatmentRecommendationsAnswer =>
      'After detecting a disease, you\'ll receive detailed treatment recommendations including care guides, preventive measures, and recovery tips.';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get emailSupport => 'Email Support';

  @override
  String get getHelpViaEmail => 'Get help via email';

  @override
  String get phoneSupport => 'Phone Support';

  @override
  String get callUsDirectly => 'Call us directly';

  @override
  String get thisFeatureComingSoon => 'This feature is coming soon!';

  @override
  String get appInformation => 'App Information';

  @override
  String get appName => 'App Name';

  @override
  String get description => 'Description';

  @override
  String get version => 'Version';

  @override
  String get packageName => 'Package Name';

  @override
  String get features => 'Features';

  @override
  String get aiDiseaseDetection => 'AI Disease Detection';

  @override
  String get aiDiseaseDetectionDesc =>
      'Advanced machine learning for accurate plant disease identification';

  @override
  String get treatmentRecommendations => 'Treatment Recommendations';

  @override
  String get treatmentRecommendationsDesc =>
      'Personalized care guides and treatment solutions';

  @override
  String get detectionHistoryDesc =>
      'Track your plant health journey over time';

  @override
  String get careGuides => 'Care Guides';

  @override
  String get careGuidesDesc => 'Comprehensive plant care information and tips';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String failedToUpdateProfile(String error) {
    return 'Failed to update profile: $error';
  }

  @override
  String get updatingProfile => 'Updating profile...';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get profilePhoto => 'Profile Photo';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get save => 'Save';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get nameMinLength => 'Name must be at least 2 characters';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue with BAGANI';

  @override
  String get email => 'Email';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinBagani => 'Join BAGANI to start your plant care journey';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterEmailForReset =>
      'Enter your email address and we\'ll send you a link to reset your password';

  @override
  String get checkEmailForReset =>
      'Check your email for password reset instructions';

  @override
  String get enterYourEmailAddress => 'Enter your email address';

  @override
  String get sendResetEmail => 'Send Reset Email';

  @override
  String get emailSent => 'Email Sent!';

  @override
  String get emailSentTo => 'We\'ve sent password reset instructions to:';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String get rememberYourPassword => 'Remember your password? ';

  @override
  String get account => 'Account';

  @override
  String get manageAccountInfo => 'Manage your account information';

  @override
  String get appSettings => 'App Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get support => 'Support';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get getHelpAndContact => 'Get help and contact support';

  @override
  String get about => 'About';

  @override
  String get appVersionAndInfo => 'App version and information';

  @override
  String get english => 'English';

  @override
  String get bengali => 'বাংলা (Bengali)';

  @override
  String get systemDefault => 'System Default';

  @override
  String get dark => 'Dark';

  @override
  String get scanYourPlantTitle => 'Scan Your Plant';

  @override
  String get loadingCureSuggestion => 'Loading cure suggestion...';

  @override
  String get retry => 'Retry';

  @override
  String get scanAnotherPlant => 'Scan Another Plant';

  @override
  String get deleteRecord => 'Delete Record';

  @override
  String get deleteRecordConfirm =>
      'Are you sure you want to delete this detection record? This action cannot be undone.';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String get pageNotFoundDesc => 'The page you are looking for does not exist.';

  @override
  String get goHome => 'Go Home';

  @override
  String get noData => 'No Data';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get addItem => 'Add Item';

  @override
  String get loadingData => 'Loading data...';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get pleaseConfirmPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordResetSent => 'Password reset email sent successfully!';

  @override
  String get credentialsCleared => 'Saved credentials cleared successfully';

  @override
  String get fetchSuggestionFailed => 'Failed to fetch suggestion: ';

  @override
  String get noUserFoundWithThisEmailAddress =>
      'No user found with this email address';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get invalidEmailAddress => 'Invalid email address';

  @override
  String get thisAccountHasBeenDisabled => 'This account has been disabled';

  @override
  String get tooManyFailedAttemptsPleaseTryAgainLater =>
      'Too many failed attempts. Please try again later';

  @override
  String get loginFailedPleaseTryAgain => 'Login failed. Please try again';

  @override
  String get anAccountWithThisEmailAlreadyExists =>
      'An account with this email already exists';

  @override
  String get passwordIsTooWeak =>
      'Password is too weak. Please choose a stronger password';

  @override
  String get emailPasswordAccountsAreNotEnabled =>
      'Email/password accounts are not enabled';

  @override
  String get signUpFailed => 'Sign up failed. Please try again';

  @override
  String get creatingAccount => 'Creating account...';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? ';
}
