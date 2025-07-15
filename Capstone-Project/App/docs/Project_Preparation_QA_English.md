# BAGANI Project - Preparation Q&A (English)

## Project Overview

**Q: What is BAGANI?**
A: BAGANI is an AI-powered mobile application for plant disease detection and care recommendations. It uses deep learning models to identify plant diseases from photos and provides treatment suggestions.

**Q: What is the main goal of BAGANI?**
A: To democratize plant disease diagnosis by making professional-grade plant care accessible to everyone via smartphones, supporting both English and Bengali languages.

**Q: What platforms does BAGANI support?**
A: Android and iOS mobile platforms using Flutter framework.

## Technical Architecture

**Q: What is the overall system architecture?**
A: Two-phase AI system: on-device disease detection using TensorFlow Lite models + cloud-based treatment recommendations using LLM API (Gemini).

**Q: What is the workflow of the application?**
A: 1) User scans plant leaf → 2) App detects disease using on-device ML → 3) App fetches treatment advice from LLM API → 4) User receives actionable recommendations.

**Q: What is the app's architecture pattern?**
A: Feature-based architecture with clean separation of concerns, using Riverpod for state management and Go Router for navigation.

## Database & Storage

**Q: What databases are used in BAGANI?**
A: SQLite for local storage (detection history) and Firebase Firestore for cloud storage (user profiles, analytics).

**Q: How does the local database work?**
A: SQLite database stores detection records locally with tables for plant name, disease name, confidence, image path, AI suggestions, and timestamps.

**Q: What is stored in Firebase Firestore?**
A: User profiles, authentication data, detection counts, healthy/diseased plant statistics, and user preferences.

**Q: How is data synchronized between local and cloud?**
A: Local data is stored immediately for offline access, while cloud data is synced when internet is available.

## Machine Learning Models

**Q: How many ML models were evaluated?**
A: 10 different deep learning architectures were evaluated: MobileNetV3Small, EfficientNet-Lite0, MobileNetV2, MobileNetV3Large, ShuffleNetV2, MiniGoogLeNet, SqueezeNet, NASNetMobile, EfficientNet-Lite1, and DenseNet121.

**Q: Which model is currently deployed in the app?**
A: DenseNet121 (98.4% accuracy) is the primary model, with MobileNetV3Large (98.1% accuracy) as an alternative for better mobile performance.

**Q: How are models integrated into the Flutter app?**
A: Models are converted to TensorFlow Lite format and integrated using the `tflite_flutter` package for on-device inference.

**Q: What is the model input/output format?**
A: Input: 224x224 RGB images, normalized to [-1, 1]. Output: 38-class probability distribution for different plant diseases.

**Q: How does the model prediction work in the app?**
A: Images are captured/selected → resized to 224x224 → normalized → fed to TFLite model → highest probability class is selected as result.

## AI Integration

**Q: How does the AI treatment recommendation work?**
A: Uses Gemini API to generate structured cure suggestions based on detected disease names, returning JSON with title, steps, and tips.

**Q: What happens when a disease is detected?**
A: The app calls PlantDiseaseService to fetch AI-powered treatment recommendations from Gemini API and stores them with the detection record.

**Q: How is the AI service implemented?**
A: Uses Dio HTTP client to make API calls to Gemini, with structured prompts to get JSON-formatted treatment recommendations.

## App Features

**Q: What are the main features of BAGANI?**
A: Real-time disease detection, AI-powered treatment recommendations, multi-language support (English/Bengali), plant care guides, detection history, user authentication, and offline-first architecture.

**Q: How does the camera/photo functionality work?**
A: Uses `image_picker` package to capture photos from camera or gallery, then processes them through the ML model for disease detection.

**Q: How is the detection history managed?**
A: All detections are stored locally in SQLite database with timestamps, confidence scores, and AI suggestions for future reference.

**Q: How does multi-language support work?**
A: Uses Flutter's localization system with ARB files for English and Bengali translations, allowing users to switch languages dynamically.

## Authentication & Security

**Q: How is user authentication implemented?**
A: Firebase Authentication for email/password signup and login, with user profiles stored in Firestore.

**Q: What security measures are in place?**
A: Firebase Auth for secure authentication, local data encryption, and secure API key management (though currently hardcoded for development).

**Q: How is user data protected?**
A: User data is stored securely in Firebase with proper authentication, and local data is stored in app's private directory.

## Performance & Optimization

**Q: How is the app optimized for mobile performance?**
A: On-device ML inference, efficient model architectures, lazy loading, and optimized image processing pipeline.

**Q: What is the app's offline capability?**
A: Disease detection works completely offline, while treatment recommendations require internet connection for AI API calls.

**Q: How is memory management handled?**
A: Efficient image processing, model lifecycle management, and proper disposal of resources to prevent memory leaks.

## Development & Deployment

**Q: What is the tech stack used?**
A: Flutter/Dart for mobile app, TensorFlow/Keras for ML models, Firebase for backend, SQLite for local storage, and various Flutter packages.

**Q: How are dependencies managed?**
A: Using pubspec.yaml for Flutter dependencies and requirements.txt for Python ML dependencies.

**Q: What is the deployment process?**
A: Models are trained in Google Colab, converted to TFLite, and bundled with the Flutter app for distribution on app stores.

## Data & Training

**Q: What dataset was used for training?**
A: PlantVillage dataset with 38 plant disease classes and 224x224 RGB images.

**Q: How was the data preprocessed?**
A: Data augmentation (rotation, shift, zoom, flip), normalization, and train/validation split (80/20).

**Q: What training strategy was used?**
A: Two-phase training: initial training followed by fine-tuning, with transfer learning from pre-trained models.

## Testing & Validation

**Q: How were the models evaluated?**
A: Using accuracy, precision, recall, F1-score, model size, and inference speed metrics with confusion matrices and classification reports.

**Q: What is the current model accuracy?**
A: DenseNet121 achieves 98.4% accuracy, making it the best performing model for disease detection.

**Q: How is the app tested?**
A: Manual testing for functionality, with plans for automated testing and user feedback collection in future iterations.

## Future Enhancements

**Q: What are planned future improvements?**
A: More plant species, web/desktop platforms, community features, advanced analytics, field testing, and continuous model improvement.

**Q: How can the model be expanded?**
A: By adding more plant species and disease classes to the training dataset and retraining the models.

**Q: What scalability considerations exist?**
A: Modular architecture allows easy addition of new features, models, and languages without major refactoring. 