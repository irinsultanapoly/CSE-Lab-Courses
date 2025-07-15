# BAGANI Flutter App – Developer Guide

This guide provides best practices, architecture patterns, and code examples to ensure consistent and scalable development for the BAGANI app.

---

## 1. Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/                        # Core functionality
│   ├── constants/              # App constants and routes
│   │     ├── app_routes.dart
│   │     └── disease_names.dart
│   ├── logger/                 # Logging utilities
│   │     └── app_logger.dart
│   ├── network/                # Network service (Dio)
│   │     └── network_service.dart
│   ├── routes/                 # Go Router configuration
│   │     └── app_router.dart
│   ├── theme/                  # App theming
│   │     └── app_theme.dart
│   └── utils/                  # Utility functions (currently empty)
├── features/                   # Feature-based modules
│   ├── care_guide/
│   │     └── presentation/
│   │           └── care_guide_screen.dart
│   ├── detection_history/
│   │     └── presentation/
│   │           └── detection_history_screen.dart
│   ├── home/
│   │     └── presentation/
│   │           └── home_screen.dart
│   ├── plant_scanning/
│   │     └── presentation/
│   │           ├── plant_scanning_screen.dart
│   │           └── prediction_result_screen.dart
│   ├── profile/
│   │     ├── domain/
│   │     │     └── profile_provider.dart
│   │     └── presentation/
│   │           └── profile_screen.dart
│   └── settings/
│         └── presentation/
│               └── settings_screen.dart
├── services/                   # App-wide services
│   ├── plant_classifier_service.dart
│   └── plant_disease_service.dart
├── shared/                     # Shared widgets and components
│   └── widgets/
│         ├── common_widgets.dart
│         ├── custom_back_button.dart
│         ├── screen_title.dart
│         └── shell_scaffold.dart
└── l10n/                       # Localization files
```

- **Feature-based**: Each feature has its own folder with `presentation`, `data`, and `domain` subfolders if needed.
- **Shared**: Place only truly reusable widgets/components here.
- **Services**: For app-wide business logic or integrations (e.g., ML, API wrappers).

---

## 2. Dependencies & Setup

### Core Dependencies
```yaml
# State Management
flutter_riverpod: ^2.5.1

# Routing
go_router: ^14.2.7

# Network
dio: ^5.4.3+1
logger: ^2.4.0

# UI & Navigation
water_drop_nav_bar: ^2.2.1
lottie: ^3.1.2

# ML & Image Processing
tflite_flutter: ^0.11.0
image_picker: ^1.1.2
camera: ^0.10.6
image: ^4.1.7

# Permissions & File Management
permission_handler: ^11.3.1
path_provider: ^2.1.3

# Localization
flutter_localizations:
  sdk: flutter
intl: any
```

### Setup Commands
```bash
# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Format code
dart format .

# Run tests
flutter test
```

---

## 3. State Management

- Use **Riverpod** for all state management.
- Prefer `StateNotifierProvider` for complex state, `Provider` for simple dependencies.

**Example:**
```dart
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
}
```

**Provider Patterns:**
```dart
// Simple provider
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// StateNotifier for complex state
final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) => UserNotifier());

// Future provider for async operations
final userDataProvider = FutureProvider<User>((ref) async {
  final api = ref.read(apiServiceProvider);
  return await api.getUser();
});
```

---

## 4. Routing & Navigation

- Use **GoRouter** for all navigation.
- Define all routes in `core/routes/app_router.dart`.
- Use named routes and constants from `core/constants/app_routes.dart`.
- For navigation, use `context.go('/route')` or `context.push('/route')`.

### Shell Route Pattern
The app uses `ShellRoute` with `ShellScaffold` for bottom navigation:

```dart
ShellRoute(
  builder: (context, state, child) {
    return ShellScaffold(location: state.uri.toString(), child: child);
  },
  routes: [
    // Shell routes (with bottom navigation)
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
  ],
),

// Feature routes (pushed on top of shell)
GoRoute(
  path: '/plant-scanning',
  builder: (context, state) => const PlantScanningScreen(),
),
```

**Navigation Examples:**
```dart
// Navigate within shell
context.go('/home');

// Push feature screen
context.push('/plant-scanning');

// Go back
context.pop();
```

---

## 5. Networking

- Use **Dio** for all HTTP requests via `NetworkService`.
- Place API logic in `core/network/` or feature-specific `data` folders.
- Use interceptors for logging/authentication.

**NetworkService Usage:**
```dart
final networkService = NetworkService();
networkService.init(baseUrl: 'https://api.example.com');

// GET request
final response = await networkService.get('/users');

// POST request
final response = await networkService.post('/users', data: userData);

// Error handling
try {
  final response = await networkService.get('/data');
} on NetworkException catch (e) {
  AppLogger.e('Network error: ${e.message}');
}
```

**API Service Pattern:**
```dart
class ApiService {
  final NetworkService _networkService = NetworkService();
  
  Future<User> getUser(String id) async {
    final response = await _networkService.get('/users/$id');
    return User.fromJson(response.data);
  }
}
```

---

## 6. Logging

- Use the `AppLogger` class for all logs.
- Do not use `print()` in production code.

**AppLogger Usage:**
```dart
import '../core/logger/app_logger.dart';

// Different log levels
AppLogger.d('Debug message');
AppLogger.i('Info message');
AppLogger.w('Warning message');
AppLogger.e('Error message');
```

---

## 7. Theming & UI

- Use `core/theme/app_theme.dart` for colors, text styles, etc.
- Use shared widgets from `shared/widgets/` for common UI.
- Follow Material 3 guidelines.

### Theme Usage
```dart
// Colors
Container(
  color: AppTheme.primaryGreen,
  child: Text('Text', style: TextStyle(color: AppTheme.darkText)),
)

// Buttons
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppTheme.accentGreen,
  ),
  onPressed: () {},
  child: Text('Button'),
)

// Cards
Card(
  child: Container(
    padding: EdgeInsets.all(16),
    child: Text('Card content'),
  ),
)
```

### Shared Widgets
```dart
// Loading state
LoadingWidget(message: 'Loading data...')

// Error state
ErrorWidget(
  message: 'Failed to load data',
  onRetry: () => loadData(),
)

// Empty state
EmptyStateWidget(
  title: 'No Data',
  description: 'No items found',
  action: ElevatedButton(onPressed: () {}, child: Text('Add Item')),
)

// Custom app bar
CustomAppBar(
  title: 'Screen Title',
  actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
)
```

---

## 8. Localization

- Place `.arb` files in `lib/l10n/`.
- Use Flutter's localization tools (`flutter gen-l10n`).
- Access strings via `AppLocalizations.of(context)`.

**Adding New Strings:**
1. Add to `lib/l10n/app_en.arb`:
```json
{
  "newFeatureTitle": "New Feature",
  "@newFeatureTitle": {
    "description": "Title for the new feature screen"
  }
}
```

2. Add to `lib/l10n/app_bn.arb`:
```json
{
  "newFeatureTitle": "নতুন বৈশিষ্ট্য"
}
```

3. Generate localizations:
```bash
flutter gen-l10n
```

4. Use in code:
```dart
Text(AppLocalizations.of(context)!.newFeatureTitle)
```

---

## 9. ML Service Pattern

- Use `tflite_flutter` for TensorFlow Lite models.
- Place ML services in `services/` folder.
- Handle model loading and prediction errors gracefully.

**ML Service Example:**
```dart
class PlantClassifierService {
  Interpreter? _interpreter;
  
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/model.tflite');
      AppLogger.i('Model loaded successfully');
    } catch (e) {
      AppLogger.e('Failed to load model: $e');
      rethrow;
    }
  }
  
  Future<List<double>> predict(File imageFile) async {
    // Preprocess image and run prediction
    // Handle errors appropriately
  }
}
```

---

## 10. Permission Handling

- Use `permission_handler` for camera and storage permissions.
- Request permissions before accessing hardware features.

**Permission Pattern:**
```dart
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission() async {
  final status = await Permission.camera.request();
  return status.isGranted;
}

// Usage
if (await requestCameraPermission()) {
  // Access camera
} else {
  // Show permission denied message
}
```

---

## 11. Asset Management

### Adding New Assets
1. **Images**: Place in `assets/images/`
2. **Animations**: Place in `assets/animations/`
3. **ML Models**: Place in `assets/models/`
4. **Update pubspec.yaml**:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/animations/
    - assets/models/
```

### Using Assets
```dart
// Images
Image.asset('assets/images/logo.png')

// Animations
Lottie.asset('assets/animations/loading.json')

// ML Models
await Interpreter.fromAsset('assets/models/model.tflite')
```

---

## 12. Feature Development Pattern

- Each feature should have its own folder under `features/`.
- Structure: `features/feature_name/presentation/`, `data/`, `domain/` as needed.
- UI code goes in `presentation/`.
- Business logic in `domain/`.
- Data sources (API, DB) in `data/`.

**Complete Feature Structure:**
```
features/new_feature/
  ├── presentation/
  │     ├── new_feature_screen.dart
  │     └── widgets/
  │           └── feature_widget.dart
  ├── data/
  │     ├── new_feature_repository.dart
  │     └── models/
  │           └── feature_model.dart
  └── domain/
        ├── new_feature_provider.dart
        └── entities/
              └── feature_entity.dart
```

---

## 13. Error Handling

### Network Errors
```dart
try {
  final response = await networkService.get('/data');
} on NetworkException catch (e) {
  AppLogger.e('Network error: ${e.message}');
  // Show user-friendly error message
}
```

### ML Model Errors
```dart
try {
  final predictions = await classifierService.predict(imageFile);
} catch (e) {
  AppLogger.e('ML prediction failed: $e');
  // Show error widget with retry option
}
```

### UI Error States
```dart
// Use ErrorWidget for consistent error display
ErrorWidget(
  message: 'Something went wrong',
  onRetry: () => loadData(),
  icon: Icons.error_outline,
)
```

---

## 14. Testing Guidelines

### Unit Tests
- Test providers and business logic
- Mock dependencies using Riverpod's testing utilities

```dart
testWidgets('Counter increments', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        counterProvider.overrideWith((ref) => CounterNotifier()),
      ],
      child: MyWidget(),
    ),
  );
  
  expect(find.text('0'), findsOneWidget);
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  expect(find.text('1'), findsOneWidget);
});
```

### Widget Tests
- Test UI components in isolation
- Use `tester.pumpWidget()` for widget testing

---

## 15. Code Style & Best Practices

- Use `dart format` for code formatting.
- Use meaningful variable and class names.
- Keep widgets small and composable.
- Avoid logic in UI widgets; use providers and domain classes.
- Document public classes and methods.

### Naming Conventions
```dart
// Files: snake_case
my_feature_screen.dart

// Classes: PascalCase
class MyFeatureScreen extends StatelessWidget {}

// Variables: camelCase
final String userName = 'John';

// Constants: SCREAMING_SNAKE_CASE
static const String API_BASE_URL = 'https://api.example.com';
```

---

## 16. Adding a New Feature – Step-by-Step Example

1. **Create folders:**
   ```bash
   mkdir -p lib/features/new_feature/{presentation,data,domain}
   ```

2. **Add UI:**
   ```dart
   // lib/features/new_feature/presentation/new_feature_screen.dart
   class NewFeatureScreen extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       return Scaffold(
         appBar: CustomAppBar(title: 'New Feature'),
         body: // Your UI here
       );
     }
   }
   ```

3. **Add business logic:**
   ```dart
   // lib/features/new_feature/domain/new_feature_provider.dart
   final newFeatureProvider = StateNotifierProvider<NewFeatureNotifier, AsyncValue<List<Item>>>((ref) => NewFeatureNotifier());
   ```

4. **Add data sources:**
   ```dart
   // lib/features/new_feature/data/new_feature_repository.dart
   class NewFeatureRepository {
     Future<List<Item>> getItems() async {
       // API call logic
     }
   }
   ```

5. **Register route:**
   ```dart
   // lib/core/routes/app_router.dart
   GoRoute(
     path: '/new-feature',
     name: 'new-feature',
     builder: (context, state) => const NewFeatureScreen(),
   ),
   ```

6. **Add route constant:**
   ```dart
   // lib/core/constants/app_routes.dart
   static const String newFeature = '/new-feature';
   ```

7. **Add localization strings:**
   ```json
   // lib/l10n/app_en.arb
   {
     "newFeatureTitle": "New Feature"
   }
   ```

8. **Run commands:**
   ```bash
   flutter gen-l10n
   dart format .
   ```

---

## 17. Common Pitfalls

- Do not put feature-specific code in `shared/` or `core/`.
- Avoid using `print()` for logs.
- Do not hardcode strings; use localization.
- Keep navigation logic out of business logic.
- Don't forget to handle loading and error states.
- Always request permissions before accessing hardware features.

---

## 18. Useful Commands

```bash
# Format code
dart format .

# Generate localization
flutter gen-l10n

# Run tests
flutter test

# Build for release
flutter build apk --release
flutter build ios --release

# Clean and rebuild
flutter clean
flutter pub get
```

---

## 19. Contribution Guidelines

- Follow this guide for all new code.
- Review pull requests for architecture and style consistency.
- Add documentation for new features and providers.
- Test your changes thoroughly.
- Update this guide when adding new patterns or dependencies.

---

## 20. Architecture Decision Record (ADR)

### Why Riverpod?
- Type-safe dependency injection
- Excellent testing support
- Automatic disposal of resources
- Better performance than Provider

### Why GoRouter?
- Declarative routing
- Deep linking support
- Type-safe route parameters
- Shell routes for complex navigation

### Why Feature-based Architecture?
- Scalability for large teams
- Clear separation of concerns
- Easy to maintain and test
- Independent feature development

---

For questions, contact the project maintainer or check the latest documentation.
