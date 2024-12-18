import 'package:bagani/config/providers.dart';
import 'package:bagani/data/models/profile/profile_request.dart';
import 'package:bagani/data/services/profile_service.dart';
import 'package:bagani/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class ProfileRepository {
  final ProfileService _profileService;
  final Ref _ref;
  final Logger _logger = Logger('ProfileRepository');

  ProfileRepository({required profileService, required ref})
      : _profileService = profileService,
        _ref = ref;

  Future<User> fetchUser(int userId) async {
    final userSuccessData = await _ref.read(userProfileProvider(userId).future);
    final profileData = userSuccessData.data;
    if (profileData != null) {
      _logger.info('Fetched profile data');
      return User.fromProfileData(profileData);
    } else {
      _logger.severe('fetchUser => profileData is null!');
      throw Exception('User profile data not present');
    }
  }

  Future<User> updateProfile(int userId, String name, String email,
      String address, String profilePicture) async {
    final profileUpdateReq = ProfileUpdateReq(
      name: name,
      email: email,
      address: address,
      profilePicture: profilePicture,
    );
    final updateSuccessRes =
        await _profileService.updateProfile(userId, profileUpdateReq);
    final profileData = updateSuccessRes.data;
    if (profileData != null) {
      _logger.info('Profile updated...');
      _ref.invalidate(userProfileProvider(userId));
      return User.fromProfileData(profileData);
    } else {
      _logger.severe('updateProfile => profileData is null!');
      throw Exception('User profile data not present');
    }
  }

  Future<bool> verifyMobile(int userId) async {
    final result = await _profileService.verifyMobile(userId);
    return result.success;
  }
}
