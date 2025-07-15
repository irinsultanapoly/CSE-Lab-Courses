# BAGANI: AI-Powered Plant Care Mobile Application

---

## Abstract
BAGANI is an AI-powered mobile application designed to democratize plant disease diagnosis and care. By leveraging state-of-the-art deep learning models and a user-friendly Flutter app, BAGANI enables real-time, offline plant disease detection and provides expert-level treatment recommendations. This document details the full thesis plan and project implementation, from conception to deployment.

---

## 1. Introduction
- **Background:** Plant diseases threaten global food security and agricultural productivity.
- **Need:** Most farmers and gardeners lack access to expert diagnosis and timely treatment.
- **Goal:** Make professional-grade plant care accessible to everyone via smartphones.

---

## 2. Motivation
- Crop losses due to disease are a major economic and food security issue.
- Early, accurate detection can prevent spread and reduce losses.
- Mobile AI solutions can reach underserved populations.

---

## 3. Problem Statement
- Manual disease identification is slow, subjective, and expertise-dependent.
- Existing digital solutions are often costly, limited, or not user-friendly.
- There is a need for an affordable, accurate, and accessible plant care tool.

---

## 4. Literature Review
- **Traditional Methods:** Visual inspection, lab testing, expert consultation.
- **AI in Agriculture:** Recent advances in deep learning for image-based disease detection.
- **Mobile AI:** TensorFlow Lite and on-device inference for real-time applications.
- **Gaps:** Most solutions lack offline capability, multi-language support, or are not open-source.

---

## 5. Objectives
- Democratize plant disease diagnosis using AI.
- Provide real-time, offline disease detection on mobile devices.
- Offer expert-level, context-aware treatment recommendations.
- Support multiple languages (English/Bengali).
- Ensure privacy, efficiency, and extensibility.

---

## 6. System Design & Architecture
- **Two-phase AI system:**
  - On-device disease detection (TensorFlow Lite models)
  - Cloud-based treatment recommendations (LLM API)
- **Mobile App:** Built with Flutter for Android/iOS
- **Workflow:**
  1. User scans plant leaf
  2. App detects disease using on-device ML
  3. App fetches treatment advice from LLM API
  4. User receives actionable recommendations
- **Architecture Diagram:**
  - [Insert diagram: Mobile App ↔ ML Model ↔ LLM API ↔ Cloud Storage]
- **Source Files:**
  - App code: `App/lib/`
  - ML models: `Models/`
  - Documentation: `App/docs/`

---

## 7. Data & Preprocessing
- **Dataset:** PlantVillage (38 plant disease classes, 224x224 RGB images)
- **Data Split:** 80% training, 20% validation
- **Augmentation:** Rotation, shift, zoom, flip
- **Preprocessing:** Normalization, resizing
- **Scripts:** See `Models/XX_ModelName.py` for each model's pipeline
- **Pipeline Details:**
  - [See `App/docs/Image Preprocessing Pipeline.md`]

---

## 8. Model Development
- **Models Evaluated:** 10 deep learning architectures (MobileNetV3Small, EfficientNet-Lite0, MobileNetV2, MobileNetV3Large, ShuffleNetV2, MiniGoogLeNet, SqueezeNet, NASNetMobile, EfficientNet-Lite1, DenseNet121)
- **Framework:** TensorFlow/Keras
- **Conversion:** All models converted to TensorFlow Lite for mobile deployment
- **Metrics:** Accuracy, Precision, Recall, F1-Score, Model Size, Inference Speed
- **Scripts:** `Models/XX_ModelName.py`

---

## 9. Training & Evaluation
- **Environment:** Google Colab for training, local for TFLite conversion
- **Strategy:** Two-phase (initial training + fine-tuning)
- **Evaluation:**
  - Confusion matrices, classification reports, training curves
  - Automated model comparison and ranking
- **Results:**
  - DenseNet121: 98.4% accuracy (best)
  - MobileNetV3Large: 98.1% (best balance)
  - SqueezeNet: 74.5% (most efficient)
- **Reports:** See `Models/DETAILED_ANALYSIS_REPORT.md` and `Models/README.md`

---

## 10. App Implementation
- **Framework:** Flutter (Dart)
- **Architecture:** Feature-based, clean separation of concerns
- **State Management:** Riverpod
- **Routing:** Go Router
- **ML Integration:** tflite_flutter package
- **Network:** Dio for API calls
- **Authentication & Storage:** Firebase
- **Localization:** English/Bengali (see `App/lib/l10n/`)
- **Key Files:**
  - Entry: `App/lib/main.dart`
  - Features: `App/lib/features/`
  - Core: `App/lib/core/`
  - Shared widgets: `App/lib/shared/widgets/`

---

## 11. App Features
- Real-time disease detection (camera/photo)
- AI-powered treatment recommendations
- Modern UI (Material 3 design)
- Multi-language support
- Plant care guides and analytics
- Offline-first architecture
- User authentication

---

## 12. Technical Stack
- **Mobile:** Flutter, Dart
- **ML:** TensorFlow, Keras, TensorFlow Lite
- **API:** LLM (OpenAI or similar)
- **Database:** SQLite (local), Firebase (cloud)
- **Other:** Riverpod, Dio, Firebase Auth, Cloud Firestore, Firebase Storage

---

## 13. Results & Discussion
- **Model Performance:**
  - All models TFLite compatible, <25MB, fast inference
  - DenseNet121 and MobileNetV3Large recommended for deployment
- **App Performance:**
  - Real-time detection on mid-range devices
  - Smooth UI/UX, low latency
- **User Feedback:**
  - [To be collected in future work]

---

## 14. Challenges & Solutions
- **Model size vs. accuracy:** Used quantization, model selection strategy
- **Mobile performance:** Optimized inference, efficient architectures
- **Data diversity:** Extensive augmentation, robust validation
- **User experience:** Iterative UI/UX testing, feedback loops
- **Integration:** Modular codebase, clear interfaces

---

## 15. Impact & Contributions
- Makes expert plant care accessible to all
- Supports sustainable agriculture and food security
- Open-source, extensible platform for future research
- Demonstrates real-world AI deployment on mobile

---

## 16. Limitations
- Limited to 38 plant disease classes (expandable)
- Treatment recommendations depend on LLM API quality
- Requires smartphone with camera and moderate specs
- User feedback and field testing pending

---

## 17. Future Work
- Integrate more plant species and diseases
- Expand to web and desktop platforms
- Add community/social features
- Continuous model improvement with user feedback
- Advanced analytics and reminders
- Field testing and user studies

---

## 18. Conclusion
- BAGANI bridges the gap between AI research and practical plant care
- Delivers accurate, fast, and accessible disease detection
- Empowers users to care for plants effectively
- Ready for real-world deployment and further innovation

---

## References
- [PlantVillage Dataset](https://www.kaggle.com/datasets/abdallahalidev/plantvillage-dataset)
- TensorFlow, Keras, Flutter, Firebase, OpenAI
- Project source code and documentation 