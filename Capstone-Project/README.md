# BAGANI PROJECT

> **AI-Powered Plant Care Mobile Application**

## 📱 Project Overview

BAGANI is an intelligent plant care mobile application built with Flutter that combines advanced AI capabilities to provide comprehensive plant health management. The app features a two-phase AI system:

**Phase 1**: On-device plant disease detection using optimized TensorFlow Lite models
**Phase 2**: Cloud-based treatment recommendations using Large Language Models (LLM) APIs

The project aims to democratize plant care by making professional-grade plant disease diagnosis and treatment suggestions accessible to everyone through their mobile devices.

## 🏗️ Project Structure

```
bagani/
├── README.md                 # Main project overview
├── Models/                   # All model implementations
│   ├── README.md            # Detailed model documentation
│   ├── 01_MobileNetV3Small.py
│   ├── 02_EfficientNet_Lite0.py
│   ├── 03_MobileNetV2.py
│   ├── 04_MobileNetV3Large.py
│   ├── 05_ShuffleNetV2.py
│   ├── 06_MiniGoogLeNet.py
│   ├── 07_SqueezeNet.py
│   ├── 08_NASNetMobile.py
│   ├── 09_EfficientNet_Lite1.py
│   └── 10_DenseNet121.py
└── App/                      # Flutter mobile application
    ├── README.md            # Flutter app documentation
    ├── lib/                 # Flutter source code
    ├── assets/              # App assets (images, models, animations)
    └── pubspec.yaml         # Flutter dependencies
```

## 🎯 Project Plan

### Phase 1: Disease Detection Engine
- **Objective**: Develop on-device ML models for real-time plant disease detection
- **Technology**: TensorFlow Lite models embedded in Flutter app
- **Benefits**: Fast, offline-capable, privacy-preserving disease identification
- **Models**: 10 optimized AI architectures for maximum accuracy and efficiency

### Phase 2: AI-Powered Treatment Recommendations
- **Objective**: Provide intelligent cure suggestions and plant care advice
- **Technology**: LLM API integration for contextual recommendations
- **Benefits**: Expert-level treatment advice, personalized care tips, preventive measures
- **Features**: Disease-specific treatments, organic alternatives, monitoring schedules

## 📋 Execution Plan

### ✅ Completed
- Model architecture selection and optimization (10 models)
- Training scripts development with comprehensive reporting
- Data preprocessing and augmentation pipelines
- Model 01-07: Training completed successfully

### 🔄 In Progress
- Model 08-10: Currently training in Google Colab (completion imminent)
- Performance evaluation and model comparison

### 📅 Upcoming
1. **Model Evaluation & Selection** (Week 1)
   - Comprehensive performance analysis of all 10 trained models
   - Accuracy-based ranking and performance benchmarking
   - TensorFlow Lite optimization for top-performing models

2. **Iterative Model Integration** (Week 2-3)
   - Start with highest accuracy model for Flutter app integration
   - Test real-world performance and compatibility
   - If integration fails → move to next best model
   - Continue until successful integration is achieved

3. **UI/UX Development** (Week 4-5)
   - Camera integration for real-time disease detection
   - Results visualization and user-friendly interface
   - Performance optimization for selected model

4. **LLM Integration** (Week 6-7)
   - API integration for treatment recommendations
   - Context-aware prompt engineering for accurate suggestions

5. **Testing & Deployment** (Week 8-9)
   - Comprehensive app testing across devices
   - Performance optimization and app store deployment

## 🚀 Quick Start

### For Model Training
1. Navigate to the `Models/` folder
2. Check the detailed README.md for model specifications
3. Run any model script (`01_*.py` to `10_*.py`) in Google Colab
4. Models will train and save optimized TensorFlow Lite files

### For Development Setup
1. Clone the repository
2. **Models**: Navigate to `Models/` folder for ML model training
3. **Flutter App**: Navigate to `App/` folder for mobile app development
   - Install Flutter dependencies: `flutter pub get`
   - Run the app: `flutter run`
4. Configure LLM API credentials (when ready for Phase 2)

## 📊 Dataset & Training

- **Dataset**: PlantVillage Dataset with 38 plant disease classes
- **Input Format**: 224×224 RGB images for consistent model input
- **Data Split**: 80% training, 20% validation for robust evaluation
- **Augmentation**: Advanced techniques including rotation, shift, zoom, and flip
- **Training Strategy**: Two-phase approach (initial training + fine-tuning)
- **Optimization**: TensorFlow Lite conversion for mobile deployment

## 📈 Current Status

### Model Training Progress
- ✅ **Models 01-07**: Successfully trained and validated
  - 01_MobileNetV3Small ✓
  - 02_EfficientNet_Lite0 ✓
  - 03_MobileNetV2 ✓
  - 04_MobileNetV3Large ✓
  - 05_ShuffleNetV2 ✓
  - 06_MiniGoogLeNet ✓
  - 07_SqueezeNet ✓

- 🔄 **Models 08-10**: Currently training in Google Colab
  - 08_NASNetMobile (In Progress)
  - 09_EfficientNet_Lite1 (In Progress)
  - 10_DenseNet121 (In Progress)

### Development Status
- ✅ Training infrastructure complete
- ✅ Model architectures finalized
- ✅ Data pipeline established
- ✅ **Flutter app foundation ready**
- 🔄 Model performance evaluation ongoing
- ⏳ Model integration with Flutter app pending
- ⏳ LLM API integration pending

## 🎯 Next Goals

### Immediate (Next 2 weeks)
1. **Complete Model Training**: Finish training models 08-10
2. **Performance Analysis**: Comprehensive accuracy evaluation and ranking of all 10 models
3. **Model Selection Strategy**: Implement iterative integration approach
   - Rank models by accuracy (best to worst)
   - Start integration with highest accuracy model
   - Test Flutter app compatibility and real-world performance
   - If issues arise → move to next best model and repeat
4. **TFLite Optimization**: Prepare mobile-optimized versions for top candidates

### Short-term (Next month)
1. **Iterative Model Integration**: Execute accuracy-based selection process
   - Test highest accuracy model in Flutter app first
   - Evaluate real-world performance and mobile compatibility
   - Fallback to next best model if integration issues occur
   - Continue until optimal model is successfully integrated
2. **Flutter App Enhancement**: Expand app functionality with camera integration
3. **UI Development**: Create intuitive interface for disease detection
4. **Testing Framework**: Establish comprehensive testing protocols

### Medium-term (Next 2 months)
1. **LLM Integration**: Implement treatment recommendation system
2. **Advanced Features**: Add plant care tracking and reminders
3. **User Testing**: Beta testing with plant enthusiasts and farmers
4. **Performance Optimization**: Fine-tune app performance and accuracy

## 🎯 Features

### Current Features (Phase 1)
- 10 state-of-the-art AI models for disease detection
- Two-phase training methodology for optimal accuracy
- Comprehensive visualization and performance reporting
- TensorFlow Lite optimization for mobile deployment
- Automated model evaluation and comparison
- Google Drive integration for results backup
- **Accuracy-based model selection strategy** for optimal app integration
- **Complete Flutter app foundation** with clean architecture
- **Modern UI with Material 3 design** and plant-care theming
- **Multi-language support** (English/Bengali)

### Planned Features (Phase 2)
- Real-time camera-based disease detection
- AI-powered treatment recommendations via LLM
- Plant care scheduling and reminders
- Disease prevention tips and early warning system
- Community features for sharing plant care experiences
- Offline-first architecture with cloud synchronization

## 🏆 Conclusion

BAGANI represents a significant step forward in democratizing plant care through AI technology. By combining cutting-edge machine learning with practical mobile application development, we're creating a tool that can transform how people care for their plants.

The project's two-phase approach ensures both immediate utility (offline disease detection) and advanced intelligence (AI-powered recommendations), making it suitable for users ranging from home gardeners to professional farmers.

With 70% of our ML models already trained and the remaining 30% in progress, we're well-positioned to deliver a comprehensive plant care solution that's both technically sophisticated and user-friendly.

---

📁 **For detailed model information, training instructions, and performance metrics, see [Models/README.md](Models/README.md)**
