import 'package:bagani/data/models/profile/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    String? email,
    required String mobile,
    required bool activeStatus,
    String? profilePicture,
    String? address,
    required bool emailVerified,
    required bool mobileVerified,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromProfileData(ProfileData profileData) => User(
        id: profileData.id,
        name: profileData.name,
        email: profileData.email,
        mobile: profileData.mobile,
        profilePicture: profileData.profilePicture,
        address: profileData.address,
        activeStatus: profileData.activeStatus,
        emailVerified: profileData.emailVerified,
        mobileVerified: profileData.mobileVerified,
      );
}
