import 'package:freezed_annotation/freezed_annotation.dart';
part 'error_response.freezed.dart';
part 'error_response.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required int statusCode,
    required String message,
    dynamic data,
    required String path,
    required String timestamp,
    required bool success,
  }) = _ErrorResponse;
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
