# BAGANI: AI-Powered Plant Care Mobile Application

---

## Slide 1: Title & Introduction
- **Project:** BAGANI – AI-Powered Plant Care Mobile Application
- **Presenter:** [Your Name]
- **Institution:** [Your University]
- **Advisors:** [Advisor Names]
- **Date:** [Presentation Date]

---

## Slide 2: Motivation
- Plant diseases cause major crop losses globally
- Early detection and treatment are critical for food security
- Most farmers/gardeners lack access to expert diagnosis
- Smartphones are widely available, enabling mobile solutions

---

## Slide 3: Problem Statement
- Manual plant disease identification is slow, error-prone, and requires expertise
- Existing solutions are expensive or not accessible to all
- Need for an affordable, accurate, and user-friendly plant care tool

---

## Slide 4: Project Objectives
- Democratize plant disease diagnosis using AI
- Provide real-time, offline disease detection on mobile devices
- Offer expert-level treatment recommendations via AI
- Support multiple languages for broader accessibility

---

## Slide 5: System Overview
- **Two-phase AI system:**
  - On-device disease detection (TensorFlow Lite)
  - Cloud-based treatment recommendations (LLM API)
- **Mobile app:** Built with Flutter for Android/iOS
- **User workflow:** Scan plant → Get diagnosis → Receive treatment advice

---

## Slide 6: Architecture Diagram
- [Insert system architecture diagram here]
- Components: Mobile App, ML Models, LLM API, Cloud Storage

---

## Slide 7: AI/ML Approach
- Evaluated 10 state-of-the-art deep learning models
- Models trained on PlantVillage dataset (38 classes)
- Metrics: Accuracy, Precision, Recall, F1-Score, Model Size, Inference Speed
- All models converted to TensorFlow Lite for mobile deployment

---

## Slide 8: Dataset & Preprocessing
- **Dataset:** PlantVillage (38 plant disease classes, 224x224 RGB images)
- **Split:** 80% training, 20% validation
- **Augmentation:** Rotation, shift, zoom, flip
- **Preprocessing:** Normalization, resizing

---

## Slide 9: Model Results (Summary)
| Model              | Accuracy | Size (MB) | Inference (ms) |
|--------------------|----------|-----------|----------------|
| DenseNet121        | 98.4%    | 7.59      | 184.15         |
| MobileNetV3Large   | 98.1%    | 4.60      | 122.48         |
| SqueezeNet         | 74.5%    | 0.77      | 88.94          |
| ...                | ...      | ...       | ...            |

- Best accuracy: DenseNet121
- Best balance: MobileNetV3Large
- Most efficient: SqueezeNet

---

## Slide 10: Mobile App Features
- Real-time disease detection (camera/photo)
- AI-powered treatment recommendations
- Modern UI (Material 3 design)
- Multi-language support (English/Bengali)
- Plant care guides and analytics
- Offline-first architecture

---

## Slide 11: Implementation Highlights
- **Flutter:** Cross-platform mobile development
- **TensorFlow Lite:** On-device ML inference
- **Riverpod:** State management
- **Dio:** Network/API integration
- **Firebase:** Authentication & storage

---

## Slide 12: Challenges & Solutions
- **Model size vs. accuracy:** Optimized with TFLite, model selection strategy
- **Mobile performance:** Quantization, efficient architectures
- **Data diversity:** Augmentation, robust validation
- **User experience:** Iterative UI/UX testing

---

## Slide 13: Impact & Contributions
- Makes expert plant care accessible to all
- Supports sustainable agriculture and food security
- Open-source, extensible platform for future research
- Demonstrates real-world AI deployment on mobile

---

## Slide 14: Future Work
- Integrate more plant species and diseases
- Expand to web and desktop platforms
- Add community/social features
- Continuous model improvement with user feedback
- Advanced analytics and reminders

---

## Slide 15: Conclusion
- BAGANI bridges the gap between AI research and practical plant care
- Delivers accurate, fast, and accessible disease detection
- Empowers users to care for plants effectively
- Ready for real-world deployment and further innovation

---

## Slide 16: Q&A
- Thank you!
- Questions and feedback welcome 