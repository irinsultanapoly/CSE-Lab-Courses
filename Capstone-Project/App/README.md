# BAGANI Flutter App

## 📱 Overview
This is the Flutter mobile application for BAGANI - an AI-powered plant care system that provides disease detection and treatment recommendations.

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                    # App entry point
├── core/                        # Core functionality
│   ├── constants/              # App constants and routes
│   ├── network/                # Network service (Dio)
│   ├── routes/                 # Go Router configuration
│   ├── theme/                  # App theming
│   └── utils/                  # Utility functions
├── features/                    # Feature-based modules
│   ├── home/                   # Home dashboard
│   ├── disease_detection/      # ML model integration
│   ├── treatment/              # LLM recommendations
│   └── profile/                # User profile
├── shared/                     # Shared widgets and components
│   └── widgets/                # Common UI components
└── l10n/                       # Localization files
```

### State Management
- **Flutter Riverpod**: Lightweight and efficient state management
- **Feature-based architecture**: Clean separation of concerns

### Key Packages
- `flutter_riverpod` - State management
- `go_router` - Navigation and routing
- `dio` - HTTP client for API calls
- `logger` - Logging system
- `water_drop_nav_bar` - Bottom navigation
- `lottie` - Animations
- `tflite_flutter` - TensorFlow Lite integration
- `camera` - Camera functionality
- `image_picker` - Image selection

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- iOS Simulator / Android Emulator / Physical device

### Installation
1. Navigate to the App directory:
   ```bash
   cd App
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate localization files:
   ```bash
   flutter gen-l10n
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🎯 Current Features
- ✅ Clean architecture with feature-based modules
- ✅ Modern UI with Material 3 design
- ✅ Navigation system with Go Router
- ✅ State management with Riverpod
- ✅ Network service with Dio
- ✅ Localization support (English/Bengali)
- ✅ Custom theming (light/dark mode)
- ✅ Water drop navigation bar

## 📋 Upcoming Features
- 🔄 TensorFlow Lite model integration
- 🔄 Camera-based disease detection
- 🔄 LLM API integration for treatment recommendations
- 🔄 Plant care tracking and reminders
- 🔄 User authentication
- 🔄 Offline-first architecture

## 🎨 Design System
- **Primary Color**: Green (#2E7D32)
- **Secondary Color**: Light Green (#66BB6A)
- **Background**: Light Green (#F1F8E9)
- **Typography**: Material 3 text styles
- **Components**: Custom Material 3 components

## 🌐 Localization
Supported languages:
- English (en)
- Bengali (bn)

Add new languages by creating `app_[locale].arb` files in `lib/l10n/`.

## 📱 Platforms
- ✅ Android
- ✅ iOS
- ✅ macOS (for development)
- 🔄 Web (future consideration)

---

This Flutter app is part of the BAGANI project ecosystem, working alongside the ML models for a complete plant care solution.
