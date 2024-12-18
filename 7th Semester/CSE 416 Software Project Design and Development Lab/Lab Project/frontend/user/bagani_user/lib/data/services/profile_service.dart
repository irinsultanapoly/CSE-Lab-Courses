import 'dart:convert';
import 'package:bagani/data/models/profile/profile_request.dart';
import 'package:bagani/data/services/client/api_client.dart';
import 'package:logging/logging.dart';

import '../exceptions/api_exceptions.dart';
import '../models/api_response/error/error_response.dart';
import '../models/api_response/success/success_response.dart';
import '../models/profile/profile_response.dart';

class ProfileService {
  final ApiClient _apiClient;
  final _logger = Logger('ProfileService');
  final _baseProfilePath = '/api/v1/users';

  ProfileService({required apiClient}) : _apiClient = apiClient;

  Future<SuccessResponse<ProfileData>> fetchUserProfile(int userId) async {
    try {
      final response = await _apiClient.get(
        '/$userId',
        basePath: _baseProfilePath,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final profileResponse = SuccessResponse<ProfileData>.fromJson(
          json,
          (data) => ProfileData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info('User profile fetched successfully');
        return profileResponse;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger
            .warning('Failed to fetch user profile: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Fetch User Profile Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<ProfileData>> updateProfile(
    int userId,
    ProfileUpdateReq updatedProfileData,
  ) async {
    try {
      final response = await _apiClient.put('/$userId',
          basePath: _baseProfilePath, body: updatedProfileData.toJson());
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final updatedProfileData = SuccessResponse<ProfileData>.fromJson(
          responseBody,
          (data) => ProfileData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info('Profile update success.');
        return updatedProfileData;
      } else {
        final errorResponse = ErrorResponse.fromJson(responseBody);
        _logger.warning('Failed to update profile: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Profile update error: ${e.toString()}');
      rethrow;
    }
  }

  Future<SuccessResponse<Null>> verifyMobile(int userId) async {
    try {
      final response = await _apiClient.put('/verify-mobile/$userId',
          basePath: _baseProfilePath, body: '');
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final mobileVerificationResult =
            SuccessResponse<Null>.fromJson(responseBody, (data) => null);
        _logger.info('Mobile Verification Success');
        return mobileVerificationResult;
      } else {
        final errorResponse = ErrorResponse.fromJson(responseBody);
        _logger.warning('Failed to verify mobile: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Error in mobile verification: ${e.toString()}');
      rethrow;
    }
  }
}
