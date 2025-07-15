import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'BAGANI'**
  String get appTitle;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Detection tab label
  ///
  /// In en, this message translates to:
  /// **'Detection'**
  String get detection;

  /// Treatment tab label
  ///
  /// In en, this message translates to:
  /// **'Treatment'**
  String get treatment;

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Welcome message on home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Plant Care'**
  String get welcomeMessage;

  /// App description on home screen
  ///
  /// In en, this message translates to:
  /// **'AI-powered disease detection and treatment recommendations'**
  String get appDescription;

  /// Detect disease feature title
  ///
  /// In en, this message translates to:
  /// **'Detect Disease'**
  String get detectDisease;

  /// Detect disease feature description
  ///
  /// In en, this message translates to:
  /// **'Take a photo to identify plant diseases'**
  String get detectDiseaseDesc;

  /// Get treatment feature title
  ///
  /// In en, this message translates to:
  /// **'Get Treatment'**
  String get getTreatment;

  /// Get treatment feature description
  ///
  /// In en, this message translates to:
  /// **'AI-powered treatment recommendations'**
  String get getTreatmentDesc;

  /// Plant analytics feature title
  ///
  /// In en, this message translates to:
  /// **'Plant Analytics'**
  String get plantAnalytics;

  /// Plant analytics feature description
  ///
  /// In en, this message translates to:
  /// **'Track your plant health over time'**
  String get plantAnalyticsDesc;

  /// Plant guide feature title
  ///
  /// In en, this message translates to:
  /// **'Plant Guide'**
  String get plantGuide;

  /// Plant guide feature description
  ///
  /// In en, this message translates to:
  /// **'Learn about plant care and diseases'**
  String get plantGuideDesc;

  /// Subtitle on home screen
  ///
  /// In en, this message translates to:
  /// **'Your AI Plant Care Companion'**
  String get yourAiCompanion;

  /// Plant scanning screen title
  ///
  /// In en, this message translates to:
  /// **'Scan Your Plant'**
  String get scanYourPlant;

  /// Description for scan action
  ///
  /// In en, this message translates to:
  /// **'AI-powered plant disease identification'**
  String get aiPoweredIdentification;

  /// Section title for recent plants
  ///
  /// In en, this message translates to:
  /// **'Your Plants'**
  String get yourPlants;

  /// View all button text
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Empty state for recent scans
  ///
  /// In en, this message translates to:
  /// **'No Recent Scans'**
  String get noRecentScans;

  /// Empty state description for recent scans
  ///
  /// In en, this message translates to:
  /// **'Start scanning your plants to see them here'**
  String get startScanning;

  /// Start scanning button text
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get startScanningButton;

  /// Scan now button text
  ///
  /// In en, this message translates to:
  /// **'Scan Now'**
  String get scanNow;

  /// History quick action label
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Care guide screen title
  ///
  /// In en, this message translates to:
  /// **'Care Guide'**
  String get careGuide;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Plants stat card label
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get plants;

  /// Healthy records label
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthy;

  /// Need care stat card label
  ///
  /// In en, this message translates to:
  /// **'Need Care'**
  String get needCare;

  /// Recent detections section title
  ///
  /// In en, this message translates to:
  /// **'Recent Detections'**
  String get recentDetections;

  /// Failed to load data message
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get failedToLoadData;

  /// Today date label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday date label
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Days ago date format
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(int days);

  /// Quick care tips section title
  ///
  /// In en, this message translates to:
  /// **'Quick Care Tips'**
  String get quickCareTips;

  /// Watering care tip title
  ///
  /// In en, this message translates to:
  /// **'Watering'**
  String get watering;

  /// Watering care tip description
  ///
  /// In en, this message translates to:
  /// **'Check soil moisture before watering. Most plants prefer slightly dry soil between watering.'**
  String get wateringDescription;

  /// Sunlight care tip title
  ///
  /// In en, this message translates to:
  /// **'Sunlight'**
  String get sunlight;

  /// Sunlight care tip description
  ///
  /// In en, this message translates to:
  /// **'Place plants near windows for natural light. Rotate weekly for even growth.'**
  String get sunlightDescription;

  /// Temperature care tip title
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// Temperature care tip description
  ///
  /// In en, this message translates to:
  /// **'Keep plants away from heat sources and cold drafts. Room temperature is usually ideal.'**
  String get temperatureDescription;

  /// Plant categories section title
  ///
  /// In en, this message translates to:
  /// **'Plant Categories'**
  String get plantCategories;

  /// Loading message for care guides
  ///
  /// In en, this message translates to:
  /// **'Loading care guides...'**
  String get loadingCareGuides;

  /// Error message when care guides fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load care guides'**
  String get failedToLoadCareGuides;

  /// Guides count label
  ///
  /// In en, this message translates to:
  /// **'Guides'**
  String get guides;

  /// Care requirements section title
  ///
  /// In en, this message translates to:
  /// **'Care Requirements'**
  String get careRequirements;

  /// Light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Water requirement label
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// Humidity requirement label
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// Soil requirement label
  ///
  /// In en, this message translates to:
  /// **'Soil'**
  String get soil;

  /// Fertilizer requirement label
  ///
  /// In en, this message translates to:
  /// **'Fertilizer'**
  String get fertilizer;

  /// Care tips section title
  ///
  /// In en, this message translates to:
  /// **'Care Tips'**
  String get careTips;

  /// Common issues section title
  ///
  /// In en, this message translates to:
  /// **'Common Issues'**
  String get commonIssues;

  /// Houseplants category name
  ///
  /// In en, this message translates to:
  /// **'Houseplants'**
  String get houseplants;

  /// Houseplants category description
  ///
  /// In en, this message translates to:
  /// **'Indoor plants for home decoration and air purification'**
  String get houseplantsDescription;

  /// Vegetables category name
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetables;

  /// Vegetables category description
  ///
  /// In en, this message translates to:
  /// **'Edible plants for home gardening and fresh produce'**
  String get vegetablesDescription;

  /// Flowers category name
  ///
  /// In en, this message translates to:
  /// **'Flowers'**
  String get flowers;

  /// Flowers category description
  ///
  /// In en, this message translates to:
  /// **'Beautiful flowering plants for gardens and decoration'**
  String get flowersDescription;

  /// Very easy difficulty level
  ///
  /// In en, this message translates to:
  /// **'Very Easy'**
  String get veryEasy;

  /// Easy difficulty level
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Moderate difficulty level
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// Difficult difficulty level
  ///
  /// In en, this message translates to:
  /// **'Difficult'**
  String get difficult;

  /// Scan screen description
  ///
  /// In en, this message translates to:
  /// **'Take a photo of your plant to detect diseases and get treatment recommendations'**
  String get takePhotoDescription;

  /// Take photo button
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// Choose from gallery button
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// Analyze button
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// Remove image button
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get removeImage;

  /// Analyzing plant loading text
  ///
  /// In en, this message translates to:
  /// **'Analyzing Plant...'**
  String get analyzingPlant;

  /// Analyzing plant loading description
  ///
  /// In en, this message translates to:
  /// **'Detecting diseases and generating solutions'**
  String get detectingDiseases;

  /// Tips section title
  ///
  /// In en, this message translates to:
  /// **'Tips for better scanning'**
  String get tipsForBetterScanning;

  /// Scanning tips text with best practices for users
  ///
  /// In en, this message translates to:
  /// **'• Take clear, well-lit photos of a single leaf or plant part\n• Avoid backgrounds with other plants or objects\n• Make sure the diseased area is visible and in focus'**
  String get scanningTips;

  /// Prediction result screen title
  ///
  /// In en, this message translates to:
  /// **'Prediction Result'**
  String get predictionResult;

  /// Prediction label
  ///
  /// In en, this message translates to:
  /// **'Prediction:'**
  String get prediction;

  /// Confidence percentage
  ///
  /// In en, this message translates to:
  /// **'Confidence: {percentage}%'**
  String confidence(String percentage);

  /// Get AI solution button text
  ///
  /// In en, this message translates to:
  /// **'Get Solution from AI'**
  String get getSolutionFromAi;

  /// Cure suggestion title
  ///
  /// In en, this message translates to:
  /// **'Cure Suggestion'**
  String get cureSuggestion;

  /// Steps section title
  ///
  /// In en, this message translates to:
  /// **'Steps:'**
  String get steps;

  /// Tips section title
  ///
  /// In en, this message translates to:
  /// **'Tips:'**
  String get tips;

  /// Best results info text
  ///
  /// In en, this message translates to:
  /// **'For best results, ensure clear images and good lighting. Tap below to get AI-powered solutions for this disease.'**
  String get forBestResults;

  /// No cure suggestion available message
  ///
  /// In en, this message translates to:
  /// **'No structured cure suggestion could be generated for this disease.'**
  String get noStructuredCureSuggestion;

  /// Failed to fetch suggestion error message
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch suggestion: {error}'**
  String failedToFetchSuggestion(String error);

  /// Detection history feature title
  ///
  /// In en, this message translates to:
  /// **'Detection History'**
  String get detectionHistory;

  /// Loading detection history message
  ///
  /// In en, this message translates to:
  /// **'Loading detection history...'**
  String get loadingDetectionHistory;

  /// Failed to load detection history error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load detection history'**
  String get failedToLoadDetectionHistory;

  /// No detection history title
  ///
  /// In en, this message translates to:
  /// **'No Detection History'**
  String get noDetectionHistory;

  /// No detection history description
  ///
  /// In en, this message translates to:
  /// **'Your plant disease detection history will appear here once you start scanning plants.'**
  String get noDetectionHistoryDescription;

  /// Total records label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Diseased records label
  ///
  /// In en, this message translates to:
  /// **'Diseased'**
  String get diseased;

  /// Error loading stats message
  ///
  /// In en, this message translates to:
  /// **'Error loading stats'**
  String get errorLoadingStats;

  /// Detection details screen title
  ///
  /// In en, this message translates to:
  /// **'Detection Details'**
  String get detectionDetails;

  /// No cure suggestion available message
  ///
  /// In en, this message translates to:
  /// **'No cure suggestion available for this disease.'**
  String get noCureSuggestionAvailable;

  /// Failed to load cure suggestion error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load cure suggestion: {error}'**
  String failedToLoadCureSuggestion(String error);

  /// Edit profile button
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Clear saved credentials button
  ///
  /// In en, this message translates to:
  /// **'Clear Saved Credentials'**
  String get clearSavedCredentials;

  /// Delete account button text
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Processing loading message
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// Sign out confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirm;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete account confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.'**
  String get deleteAccountConfirm;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Clear credentials confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all saved credentials? You will need to enter them again next time.'**
  String get clearCredentialsConfirm;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Sign out error message
  ///
  /// In en, this message translates to:
  /// **'Sign out failed: '**
  String get signOutFailed;

  /// Account deletion error message
  ///
  /// In en, this message translates to:
  /// **'Account deletion failed: '**
  String get accountDeletionFailed;

  /// Clear credentials error message
  ///
  /// In en, this message translates to:
  /// **'Failed to clear credentials: '**
  String get clearCredentialsFailed;

  /// Credentials cleared success message
  ///
  /// In en, this message translates to:
  /// **'Saved credentials cleared successfully'**
  String get savedCredentialsCleared;

  /// Updating language loading message
  ///
  /// In en, this message translates to:
  /// **'Updating language...'**
  String get updatingLanguage;

  /// Language updated success message
  ///
  /// In en, this message translates to:
  /// **'Language updated to {language}'**
  String languageUpdatedTo(String language);

  /// Failed to update language error message
  ///
  /// In en, this message translates to:
  /// **'Failed to update language: {error}'**
  String failedToUpdateLanguage(String error);

  /// Updating theme loading message
  ///
  /// In en, this message translates to:
  /// **'Updating theme...'**
  String get updatingTheme;

  /// Theme updated success message
  ///
  /// In en, this message translates to:
  /// **'Theme updated to {theme}'**
  String themeUpdatedTo(String theme);

  /// Failed to update theme error message
  ///
  /// In en, this message translates to:
  /// **'Failed to update theme: {error}'**
  String failedToUpdateTheme(String error);

  /// System theme description
  ///
  /// In en, this message translates to:
  /// **'Follows your device settings'**
  String get followsDeviceSettings;

  /// Light theme description
  ///
  /// In en, this message translates to:
  /// **'Light theme for bright environments'**
  String get lightThemeDescription;

  /// Dark theme description
  ///
  /// In en, this message translates to:
  /// **'Dark theme for low-light environments'**
  String get darkThemeDescription;

  /// FAQ section title
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// FAQ question about disease detection
  ///
  /// In en, this message translates to:
  /// **'How to detect plant diseases?'**
  String get howToDetectPlantDiseases;

  /// FAQ answer about disease detection
  ///
  /// In en, this message translates to:
  /// **'Take a photo of your plant\'s affected area using the camera feature. Our AI will analyze the image and provide disease identification with treatment recommendations.'**
  String get diseaseDetectionAnswer;

  /// FAQ question about detection accuracy
  ///
  /// In en, this message translates to:
  /// **'How accurate is the disease detection?'**
  String get howAccurateIsDetection;

  /// FAQ answer about detection accuracy
  ///
  /// In en, this message translates to:
  /// **'Our AI model has been trained on thousands of plant disease images and achieves high accuracy. However, for critical cases, we recommend consulting with a plant expert.'**
  String get detectionAccuracyAnswer;

  /// FAQ question about saving history
  ///
  /// In en, this message translates to:
  /// **'Can I save my detection history?'**
  String get canISaveDetectionHistory;

  /// FAQ answer about saving history
  ///
  /// In en, this message translates to:
  /// **'Yes! All your detections are automatically saved and can be accessed from the Detection History tab. You can view past results and treatment recommendations.'**
  String get detectionHistoryAnswer;

  /// FAQ question about treatment recommendations
  ///
  /// In en, this message translates to:
  /// **'How to get treatment recommendations?'**
  String get howToGetTreatment;

  /// FAQ answer about treatment recommendations
  ///
  /// In en, this message translates to:
  /// **'After detecting a disease, you\'ll receive detailed treatment recommendations including care guides, preventive measures, and recovery tips.'**
  String get treatmentRecommendationsAnswer;

  /// Contact support section title
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// Email support card title
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupport;

  /// Email support description
  ///
  /// In en, this message translates to:
  /// **'Get help via email'**
  String get getHelpViaEmail;

  /// Phone support card title
  ///
  /// In en, this message translates to:
  /// **'Phone Support'**
  String get phoneSupport;

  /// Phone support description
  ///
  /// In en, this message translates to:
  /// **'Call us directly'**
  String get callUsDirectly;

  /// Coming soon message
  ///
  /// In en, this message translates to:
  /// **'This feature is coming soon!'**
  String get thisFeatureComingSoon;

  /// App information section title
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInformation;

  /// App name label
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appName;

  /// Description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Package name label
  ///
  /// In en, this message translates to:
  /// **'Package Name'**
  String get packageName;

  /// Features section title
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// AI disease detection feature title
  ///
  /// In en, this message translates to:
  /// **'AI Disease Detection'**
  String get aiDiseaseDetection;

  /// AI disease detection feature description
  ///
  /// In en, this message translates to:
  /// **'Advanced machine learning for accurate plant disease identification'**
  String get aiDiseaseDetectionDesc;

  /// Treatment recommendations feature title
  ///
  /// In en, this message translates to:
  /// **'Treatment Recommendations'**
  String get treatmentRecommendations;

  /// Treatment recommendations feature description
  ///
  /// In en, this message translates to:
  /// **'Personalized care guides and treatment solutions'**
  String get treatmentRecommendationsDesc;

  /// Detection history feature description
  ///
  /// In en, this message translates to:
  /// **'Track your plant health journey over time'**
  String get detectionHistoryDesc;

  /// Care guides feature title
  ///
  /// In en, this message translates to:
  /// **'Care Guides'**
  String get careGuides;

  /// Care guides feature description
  ///
  /// In en, this message translates to:
  /// **'Comprehensive plant care information and tips'**
  String get careGuidesDesc;

  /// Update profile button text
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// Profile update success message
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// Profile update failed error message
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile: {error}'**
  String failedToUpdateProfile(String error);

  /// Updating profile loading message
  ///
  /// In en, this message translates to:
  /// **'Updating profile...'**
  String get updatingProfile;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// Profile photo field label
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhoto;

  /// Change photo button text
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// Remove photo button text
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// Name length validation error
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameMinLength;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue with BAGANI'**
  String get signInToContinue;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// Remember me checkbox text
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign up prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Sign up screen title
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Sign up screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Join BAGANI to start your plant care journey'**
  String get joinBagani;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Confirm password field hint
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// Reset password screen title
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Reset password screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password'**
  String get enterEmailForReset;

  /// Reset password success message
  ///
  /// In en, this message translates to:
  /// **'Check your email for password reset instructions'**
  String get checkEmailForReset;

  /// Email field hint for reset
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmailAddress;

  /// Send reset email button
  ///
  /// In en, this message translates to:
  /// **'Send Reset Email'**
  String get sendResetEmail;

  /// Email sent success title
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSent;

  /// Email sent success message
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent password reset instructions to:'**
  String get emailSentTo;

  /// Resend email button
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// Back to login prompt
  ///
  /// In en, this message translates to:
  /// **'Remember your password? '**
  String get rememberYourPassword;

  /// Account section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Profile card description
  ///
  /// In en, this message translates to:
  /// **'Manage your account information'**
  String get manageAccountInfo;

  /// App settings section title
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Language setting title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme setting title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Support section title
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Help and support title
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// Help and support description
  ///
  /// In en, this message translates to:
  /// **'Get help and contact support'**
  String get getHelpAndContact;

  /// About title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// About description
  ///
  /// In en, this message translates to:
  /// **'App version and information'**
  String get appVersionAndInfo;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Bengali language name
  ///
  /// In en, this message translates to:
  /// **'বাংলা (Bengali)'**
  String get bengali;

  /// System default theme
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Scan screen title
  ///
  /// In en, this message translates to:
  /// **'Scan Your Plant'**
  String get scanYourPlantTitle;

  /// Loading cure suggestion text
  ///
  /// In en, this message translates to:
  /// **'Loading cure suggestion...'**
  String get loadingCureSuggestion;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Scan another plant button
  ///
  /// In en, this message translates to:
  /// **'Scan Another Plant'**
  String get scanAnotherPlant;

  /// Delete record button
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecord;

  /// Delete record confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this detection record? This action cannot be undone.'**
  String get deleteRecordConfirm;

  /// Signing in loading message
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// 404 page title
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// 404 page description
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get pageNotFoundDesc;

  /// Go home button
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No data title
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No items found description
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// Add item button
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// Loading data message
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get loadingData;

  /// Email validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Valid email validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// Password validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Password length validation error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Confirm password validation error
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// Password match validation error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Password reset success message
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully!'**
  String get passwordResetSent;

  /// Credentials cleared success message
  ///
  /// In en, this message translates to:
  /// **'Saved credentials cleared successfully'**
  String get credentialsCleared;

  /// Fetch suggestion error message
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch suggestion: '**
  String get fetchSuggestionFailed;

  /// No description provided for @noUserFoundWithThisEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email address'**
  String get noUserFoundWithThisEmailAddress;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmailAddress;

  /// No description provided for @thisAccountHasBeenDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get thisAccountHasBeenDisabled;

  /// No description provided for @tooManyFailedAttemptsPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Please try again later'**
  String get tooManyFailedAttemptsPleaseTryAgainLater;

  /// No description provided for @loginFailedPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again'**
  String get loginFailedPleaseTryAgain;

  /// No description provided for @anAccountWithThisEmailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get anAccountWithThisEmailAlreadyExists;

  /// No description provided for @passwordIsTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please choose a stronger password'**
  String get passwordIsTooWeak;

  /// No description provided for @emailPasswordAccountsAreNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Email/password accounts are not enabled'**
  String get emailPasswordAccountsAreNotEnabled;

  /// No description provided for @signUpFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed. Please try again'**
  String get signUpFailed;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccount;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
