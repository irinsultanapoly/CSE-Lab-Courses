# Firebase Setup for BAGANI App

This guide will help you set up Firebase Authentication for the BAGANI Flutter app.

## Prerequisites

1. Flutter SDK installed
2. Firebase CLI installed (`npm install -g firebase-tools`)
3. FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `bagani-app` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Enable Authentication

1. In Firebase Console, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

## Step 3: Enable Firestore Database

1. In Firebase Console, go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location close to your users
5. Click "Done"

## Step 4: Configure Flutter App

### Option A: Using FlutterFire CLI (Recommended)

1. Run the following command in the App directory:
   ```bash
   flutterfire configure --project=your-project-id
   ```

2. This will automatically:
   - Create platform-specific Firebase configuration files
   - Update `firebase_options.dart` with your actual configuration
   - Add necessary files to your project

### Option B: Manual Configuration

1. In Firebase Console, go to "Project settings" (gear icon)
2. Scroll down to "Your apps" section
3. Click "Add app" and select your platform (Android/iOS/Web)
4. Follow the setup instructions for each platform
5. Download the configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
   - Web configuration for web

6. Update `lib/firebase_options.dart` with your actual configuration values

## Step 5: Platform-Specific Setup

### Android Setup

1. Place `google-services.json` in `android/app/`
2. Update `android/build.gradle`:
   ```gradle
   buildscript {
       dependencies {
           classpath 'com.google.gms:google-services:4.3.15'
       }
   }
   ```

3. Update `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

### iOS Setup

1. Place `GoogleService-Info.plist` in `ios/Runner/`
2. Add it to your Xcode project (drag and drop into Runner folder)
3. Make sure it's included in your target

### Web Setup

1. The web configuration is handled automatically by FlutterFire CLI
2. If manual setup, add the Firebase SDK to `web/index.html`

## Step 6: Security Rules

### Firestore Security Rules

Update your Firestore security rules in Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow read access to care guides for all authenticated users
    match /care_guides/{document} {
      allow read: if request.auth != null;
    }
  }
}
```

## Step 7: Test the Setup

1. Run the app:
   ```bash
   flutter run
   ```

2. Test authentication features:
   - Sign up with email/password
   - Sign in with existing account
   - Forgot password functionality
   - Sign out
   - Profile management

## Troubleshooting

### Common Issues

1. **Firebase not initialized**: Make sure you've added the configuration files and updated `firebase_options.dart`

2. **Authentication errors**: Check that Email/Password provider is enabled in Firebase Console

3. **Firestore permission errors**: Verify your security rules allow the operations you're trying to perform

4. **Platform-specific issues**: Ensure you've followed the platform-specific setup steps

### Debug Mode

For development, you can use Firebase Emulator Suite:

1. Install Firebase CLI
2. Run `firebase init emulators`
3. Start emulators: `firebase emulators:start`
4. Update your app to use emulators (see Firebase documentation)

## Production Considerations

1. **Security Rules**: Update Firestore security rules for production
2. **Authentication**: Consider adding additional sign-in methods (Google, Apple, etc.)
3. **Monitoring**: Set up Firebase Analytics and Crashlytics
4. **Backup**: Set up automated backups for your Firestore database

## Support

If you encounter issues:

1. Check Firebase Console for error logs
2. Review FlutterFire documentation
3. Check Firebase Flutter plugin documentation
4. Review the app logs using `AppLogger`

## Next Steps

After Firebase setup is complete:

1. Test all authentication flows
2. Implement user profile management
3. Add data synchronization between local SQLite and Firestore
4. Set up user analytics and monitoring
5. Implement offline support with Firestore persistence 