import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../services/local_storage_service.dart';
import '../../../core/logger/app_logger.dart';

// Provider for FirebaseAuthService
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// Provider for current user
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

// Provider for profile data
final profileProvider = StreamProvider<ProfileData>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges.map((user) {
    if (user == null) {
      return ProfileData(
        name: '',
        email: '',
        avatarUrl: null,
        detectionCount: 0,
        healthyPlantCount: 0,
        diseasedPlantCount: 0,
      );
    }

    return ProfileData(
      name: user.displayName ?? 'User',
      email: user.email ?? '',
      avatarUrl: user.photoURL,
      detectionCount: 0, // Will be updated from Firestore
      healthyPlantCount: 0, // Will be updated from Firestore
      diseasedPlantCount: 0, // Will be updated from Firestore
    );
  });
});

// Provider for detailed profile data from Firestore
final detailedProfileProvider = FutureProvider<ProfileData?>((ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final user = authService.currentUser;

  if (user == null) return null;

  try {
    final profileData = await authService.getUserProfile();
    if (profileData != null) {
      return ProfileData(
        name: profileData['displayName'] ?? user.displayName ?? 'User',
        email: profileData['email'] ?? user.email ?? '',
        avatarUrl: profileData['photoURL'] ?? user.photoURL,
        detectionCount: profileData['detectionCount'] ?? 0,
        healthyPlantCount: profileData['healthyPlantCount'] ?? 0,
        diseasedPlantCount: profileData['diseasedPlantCount'] ?? 0,
      );
    }
  } catch (e) {
    AppLogger.e('Failed to get detailed profile: $e');
  }

  // Fallback to basic user data
  return ProfileData(
    name: user.displayName ?? 'User',
    email: user.email ?? '',
    avatarUrl: user.photoURL,
    detectionCount: 0,
    healthyPlantCount: 0,
    diseasedPlantCount: 0,
  );
});

// Provider for LocalStorageService
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Profile state notifier for updates
final profileStateProvider =
    StateNotifierProvider<ProfileStateNotifier, AsyncValue<ProfileData?>>((
      ref,
    ) {
      final authService = ref.watch(firebaseAuthServiceProvider);
      final storageService = ref.watch(localStorageServiceProvider);
      return ProfileStateNotifier(authService, storageService);
    });

class ProfileStateNotifier extends StateNotifier<AsyncValue<ProfileData?>> {
  final FirebaseAuthService _authService;
  final LocalStorageService _storageService;

  ProfileStateNotifier(this._authService, this._storageService)
    : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final user = _authService.currentUser;

      if (user == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final profileData = await _authService.getUserProfile();
      if (profileData != null) {
        final profile = ProfileData(
          name: profileData['displayName'] ?? user.displayName ?? 'User',
          email: profileData['email'] ?? user.email ?? '',
          avatarUrl: profileData['photoURL'] ?? user.photoURL,
          localImagePath: profileData['localImagePath'],
          detectionCount: profileData['detectionCount'] ?? 0,
          healthyPlantCount: profileData['healthyPlantCount'] ?? 0,
          diseasedPlantCount: profileData['diseasedPlantCount'] ?? 0,
        );
        state = AsyncValue.data(profile);
      } else {
        // Fallback to basic user data
        final profile = ProfileData(
          name: user.displayName ?? 'User',
          email: user.email ?? '',
          avatarUrl: user.photoURL,
          localImagePath: null,
          detectionCount: 0,
          healthyPlantCount: 0,
          diseasedPlantCount: 0,
        );
        state = AsyncValue.data(profile);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      AppLogger.e('Failed to load profile: $e');
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? localImagePath,
  }) async {
    try {
      state = const AsyncValue.loading();

      // Update display name in Firebase Auth
      if (displayName != null) {
        await _authService.updateUserProfile(
          displayName: displayName,
          photoURL: null, // We're not using Firebase Storage for photos
        );
      }

      // Update local image path in Firestore
      if (localImagePath != null) {
        await _updateLocalImagePathInFirestore(localImagePath);
      }

      // Reload profile after update
      await _loadProfile();

      AppLogger.i('Profile updated successfully');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      AppLogger.e('Profile update failed: $e');
      rethrow;
    }
  }

  Future<void> _updateLocalImagePathInFirestore(String localImagePath) async {
    try {
      final user = _authService.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'localImagePath': localImagePath,
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
      AppLogger.i('Local image path updated in Firestore: $localImagePath');
    } catch (e) {
      AppLogger.e('Failed to update local image path in Firestore: $e');
      rethrow;
    }
  }

  Future<void> refreshProfile() async {
    await _loadProfile();
  }
}

class ProfileData {
  final String name;
  final String email;
  final String? avatarUrl;
  final String? localImagePath; // Add local image path
  final int detectionCount;
  final int healthyPlantCount;
  final int diseasedPlantCount;

  ProfileData({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.localImagePath,
    this.detectionCount = 0,
    this.healthyPlantCount = 0,
    this.diseasedPlantCount = 0,
  });

  ProfileData copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? localImagePath,
    int? detectionCount,
    int? healthyPlantCount,
    int? diseasedPlantCount,
  }) {
    return ProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      detectionCount: detectionCount ?? this.detectionCount,
      healthyPlantCount: healthyPlantCount ?? this.healthyPlantCount,
      diseasedPlantCount: diseasedPlantCount ?? this.diseasedPlantCount,
    );
  }
}
