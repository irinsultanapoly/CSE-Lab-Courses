import 'package:freezed_annotation/freezed_annotation.dart';

part 'success_response.freezed.dart';

@freezed
class SuccessResponse<T> with _$SuccessResponse<T> {
  const factory SuccessResponse({
    required int statusCode,
    required String message,
    required T? data,
    required String path,
    required String timestamp,
    required bool success,
  }) = _SuccessResponse<T>;

  factory SuccessResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(Object?) fromJsonT,
  ) {
    return _SuccessResponse<T>(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: fromJsonT(json['data']),
      path: json['path'] as String,
      timestamp: json['timestamp'] as String,
      success: json['success'] as bool,
    );
  }
}
