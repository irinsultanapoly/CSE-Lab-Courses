import 'package:bagani/data/exceptions/api_exceptions.dart';
import 'package:bagani/data/models/api_response/success/success_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import '../models/api_response/error/error_response.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/auth_response.dart';
import 'client/api_client.dart';

class AuthService {
  final ApiClient _apiClient;
  final _baseAuthPath = '/api/v1/users';

  final _logger = Logger('AuthService');

  AuthService({required apiClient}) : _apiClient = apiClient;

  Future<SuccessResponse<RegistrationData>> register(
      RegisterRequest request) async {
    try {
      final response = await _apiClient.post(
        '/register',
        basePath: _baseAuthPath,
        body: request.toJson(),
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final registrationResponse = SuccessResponse<RegistrationData>.fromJson(
          json,
          (data) => RegistrationData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info(
            'User registered successfully with ID: ${registrationResponse.data?.id}');
        return registrationResponse;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Registration failed: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Registration Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<LoginData>> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        '/login',
        basePath: _baseAuthPath,
        body: request.toJson(),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final loginResponse = SuccessResponse<LoginData>.fromJson(
          json,
          (data) => LoginData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info(
            'User logged in successfully with token: ${loginResponse.data?.token}');
        return loginResponse;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Login failed: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Login Error', e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiClient.post(
        '/logout',
        basePath: _baseAuthPath,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _logger.info('User logged out successfully.');
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Logout failed: ${errorResponse.message}');
        // throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Logout Error', e);
      // rethrow;
    }
  }
}
