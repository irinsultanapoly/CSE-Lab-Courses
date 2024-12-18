import 'package:bagani/data/repositories/auth_repository.dart';
import 'package:bagani/data/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class ProfileState {
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String profilePictureUrl;

  ProfileState({
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.profilePictureUrl,
  });
}

class ProfileViewModel extends StateNotifier<AsyncValue<ProfileState>> {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final Logger _logger = Logger('ProfileViewModel');

  ProfileViewModel({
    required ProfileRepository profileRepository,
    required AuthRepository authRepository,
  })  : _profileRepository = profileRepository,
        _authRepository = authRepository,
        super(
          const AsyncValue.loading(),
        );

  Future<void> fetchProfile(int userId) async {
    try {
      _logger.info('Fetching profile for user ID: $userId');
      state = const AsyncValue.loading();
      final userData = await _profileRepository.fetchUser(userId);
      state = AsyncValue.data(ProfileState(
        name: userData.name,
        email: userData.email ?? '',
        mobile: userData.mobile,
        address: userData.address ?? '',
        profilePictureUrl: userData.profilePicture ??
            "https://avatar.iran.liara.run/public/boy?username=Ash",
      ));
      _logger.info('Profile fetched successfully for user ID: $userId');
    } catch (e, s) {
      _logger.severe('Error fetching profile for user ID: $userId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> updateProfile(
      int userId, String name, String email, String address) async {
    try {
      _logger.info('Updating profile for user ID: $userId');
      state = const AsyncValue.loading();
      final userData = await _profileRepository.updateProfile(
          userId,
          name,
          email,
          address,
          "https://avatar.iran.liara.run/public/boy?username=Ash");
      state = AsyncValue.data(
        ProfileState(
          name: userData.name,
          email: userData.email ?? '',
          mobile: userData.mobile,
          address: userData.address ?? '',
          profilePictureUrl: userData.profilePicture ??
              "https://avatar.iran.liara.run/public/boy?username=Ash",
        ),
      );
      _logger.info('Profile updated successfully for user ID: $userId');
    } catch (e, s) {
      _logger.severe('Error updating profile for user ID: $userId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  Future<bool> verifyMobile(int userId) async {
    try {
      _logger.info('Verifying mobile for user ID: $userId');
      final lastState = state.value;
      state = const AsyncValue.loading();
      final isVerified = await _profileRepository.verifyMobile(userId);
      state = AsyncValue.data(lastState!); // Restore the previous state
      _logger.info('Mobile verification successful for user ID: $userId');
      return isVerified;
    } catch (e, s) {
      _logger.severe('Error verifying mobile for user ID: $userId', e, s);
      state = AsyncValue.error(e, s);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _logger.info('Logging out the user');
      await _authRepository.logout(); // Call repository logout method
      // state = const AsyncValue.loading(); // Clear the state on logout
      _logger.info('User logged out successfully');
    } catch (e, s) {
      _logger.severe('Error during logout', e, s);
      state = AsyncValue.error(e, s);
    }
  }
}
