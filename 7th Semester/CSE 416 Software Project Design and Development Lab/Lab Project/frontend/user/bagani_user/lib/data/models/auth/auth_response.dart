// auth_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class RegistrationData with _$RegistrationData {
  const factory RegistrationData({
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
  }) = _RegistrationData;
  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDataFromJson(json);
}

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    required String token,
    required int userId,
    required String role,
    required bool activeStatus,
  }) = _LoginData;
  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
