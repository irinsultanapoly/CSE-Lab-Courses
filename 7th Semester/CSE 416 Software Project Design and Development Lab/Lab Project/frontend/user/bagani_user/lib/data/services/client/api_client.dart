import 'dart:convert';

import 'package:bagani/data/exceptions/api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../models/api_response/error/error_response.dart';

class ApiClient {
  final Logger _logger = Logger('ApiClient');
  final String _baseUrl;
  final Map<String, String> _defaultHeaders;

  ApiClient({
    required String baseUrl,
    Map<String, String> defaultHeaders = const {},
  })  : _baseUrl = baseUrl,
        _defaultHeaders = defaultHeaders;

  Future<http.Response> get(String path,
      {String? basePath, Map<String, String>? headers}) async {
    return _makeRequest(() => http.get(
          Uri.parse('$_baseUrl${basePath ?? ''}$path'),
          headers: {..._defaultHeaders, ...?headers},
        ));
  }

  Future<http.Response> post(String path,
      {String? basePath, Map<String, String>? headers, dynamic body}) async {
    return _makeRequest(() => http.post(
          Uri.parse('$_baseUrl${basePath ?? ''}$path'),
          headers: {..._defaultHeaders, ...?headers},
          body: jsonEncode(body),
        ));
  }

  Future<http.Response> put(String path,
      {String? basePath, Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$_baseUrl${basePath ?? ''}$path');
    final combinedHeaders = {
      ..._defaultHeaders,
      ...?headers,
    };
    final encodedBody = jsonEncode(body);
    return _makeRequest(
        () => http.put(url, headers: combinedHeaders, body: encodedBody));
  }

  Future<http.Response> delete(String path,
      {String? basePath, Map<String, String>? headers}) async {
    return _makeRequest(() => http.delete(
          Uri.parse('$_baseUrl${basePath ?? ''}$path'),
          headers: {..._defaultHeaders, ...?headers},
        ));
  }

  Future<http.Response> _makeRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      return _handleResponse(response);
    } catch (e) {
      _logger.severe('Api failed: ${e.toString()}');
      rethrow;
    }
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      _logger.info('Api success with status code: ${response.statusCode}');
      return response;
    } else {
      _logger.info('Api failed with status code: ${response.statusCode}');
      final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
      throw ApiException.fromErrorResponse(errorResponse);
    }
  }
}
