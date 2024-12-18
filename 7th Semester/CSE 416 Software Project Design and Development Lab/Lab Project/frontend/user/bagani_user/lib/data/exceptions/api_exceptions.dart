import '../models/api_response/error/error_response.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException(this.statusCode, this.message, {this.data});

  ApiException.fromErrorResponse(ErrorResponse errorResponse)
      : message = errorResponse.message,
        statusCode = errorResponse.statusCode,
        data = errorResponse.data;

  @override
  String toString() => message;
}
