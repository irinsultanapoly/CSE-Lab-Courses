import 'package:bagani/config/app_configs.dart';
import 'package:bagani/data/models/api_response/success/success_response.dart';
import 'package:bagani/data/models/plant/plant.dart';
import 'package:bagani/data/models/plant/plant_response.dart';
import 'package:bagani/data/models/profile/profile_response.dart';
import 'package:bagani/data/repositories/auth_repository.dart';
import 'package:bagani/data/repositories/plant_repository.dart';
import 'package:bagani/data/repositories/profile_repository.dart';
import 'package:bagani/data/services/auth_service.dart';
import 'package:bagani/data/services/client/api_client.dart';
import 'package:bagani/data/services/plant_service.dart';
import 'package:bagani/data/services/profile_service.dart';
import 'package:bagani/ui/auth/auth_view_model.dart';
import 'package:bagani/ui/profile/profile_view_model.dart';
import 'package:bagani/ui/store/store_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' as Foundation;

//Common
final apiClientProvider = Provider<ApiClient>((ref) {
  String baseUrl;

  if (Foundation.defaultTargetPlatform == Foundation.TargetPlatform.android) {
    // For Android Emulator, use 10.0.2.2 to refer to localhost
    baseUrl = 'http://10.0.2.2:8080'; // Adjust port as necessary
  } else {
    // For other platforms (iOS, Web, etc.), use localhost or actual IP
    baseUrl =
        'http://localhost:8080'; // or use your local IP, e.g., 'http://192.168.1.100:8080'
  }
  return ApiClient(
    baseUrl: baseUrl,
    defaultHeaders: defaultApiHeaders,
  );
});

//Auth
final authServiceProvider = Provider((ref) {
  return AuthService(apiClient: ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<AuthState>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository);
});

//Profile
final profileServiceProvider = Provider((ref) {
  return ProfileService(apiClient: ref.watch(apiClientProvider));
});

final userProfileProvider =
    FutureProviderFamily<SuccessResponse<ProfileData>, int>(
        (ref, userId) async {
  final profileService = ref.watch(profileServiceProvider);
  return await profileService.fetchUserProfile(userId);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(
      profileService: ref.watch(profileServiceProvider), ref: ref);
});

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, AsyncValue<ProfileState>>((ref) {
  return ProfileViewModel(
    profileRepository: ref.watch(profileRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  );
});

// Plant Service Provider
final plantServiceProvider = Provider<PlantService>((ref) {
  return PlantService(apiClient: ref.read(apiClientProvider));
});

// Plant Repository Provider
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final plantService = ref.read(plantServiceProvider);
  return PlantRepository(plantService: plantService, ref: ref);
});

// Fetch Plant By ID Provider
final plantByIdProvider =
    FutureProvider.family<SuccessResponse<PlantData>, int>(
        (ref, plantId) async {
  final plantService = ref.read(plantServiceProvider);
  return await plantService.getPlantById(plantId);
});

// Fetch All Plants By User ID Provider
final plantsByUserIdProvider =
    FutureProvider.family<SuccessResponse<List<PlantData>>, int>(
        (ref, userId) async {
  final plantService = ref.read(plantServiceProvider);
  return plantService.getAllPlantsByUserId(userId);
});

final storeViewModelProvider =
    StateNotifierProvider<StoreViewModel, AsyncValue<PlantState>>((ref) {
  return StoreViewModel(
    plantRepository: ref.watch(plantRepositoryProvider),
  );
});
