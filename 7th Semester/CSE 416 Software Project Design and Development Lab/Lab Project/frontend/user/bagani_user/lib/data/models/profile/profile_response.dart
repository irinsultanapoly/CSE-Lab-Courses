import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class ProfileData with _$ProfileData {
  const factory ProfileData({
    required int id,
    required String name,
    String? email,
    required String mobile,
    required bool activeStatus,
    String? profilePicture,
    String? address,
    required String role,
    required bool emailVerified,
    required bool mobileVerified,
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
}
