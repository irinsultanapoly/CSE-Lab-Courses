// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'success_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SuccessResponse<T> {
  int get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuccessResponseCopyWith<T, SuccessResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuccessResponseCopyWith<T, $Res> {
  factory $SuccessResponseCopyWith(
          SuccessResponse<T> value, $Res Function(SuccessResponse<T>) then) =
      _$SuccessResponseCopyWithImpl<T, $Res, SuccessResponse<T>>;
  @useResult
  $Res call(
      {int statusCode,
      String message,
      T? data,
      String path,
      String timestamp,
      bool success});
}

/// @nodoc
class _$SuccessResponseCopyWithImpl<T, $Res, $Val extends SuccessResponse<T>>
    implements $SuccessResponseCopyWith<T, $Res> {
  _$SuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? data = freezed,
    Object? path = null,
    Object? timestamp = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuccessResponseImplCopyWith<T, $Res>
    implements $SuccessResponseCopyWith<T, $Res> {
  factory _$$SuccessResponseImplCopyWith(_$SuccessResponseImpl<T> value,
          $Res Function(_$SuccessResponseImpl<T>) then) =
      __$$SuccessResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {int statusCode,
      String message,
      T? data,
      String path,
      String timestamp,
      bool success});
}

/// @nodoc
class __$$SuccessResponseImplCopyWithImpl<T, $Res>
    extends _$SuccessResponseCopyWithImpl<T, $Res, _$SuccessResponseImpl<T>>
    implements _$$SuccessResponseImplCopyWith<T, $Res> {
  __$$SuccessResponseImplCopyWithImpl(_$SuccessResponseImpl<T> _value,
      $Res Function(_$SuccessResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? data = freezed,
    Object? path = null,
    Object? timestamp = null,
    Object? success = null,
  }) {
    return _then(_$SuccessResponseImpl<T>(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessResponseImpl<T> implements _SuccessResponse<T> {
  const _$SuccessResponseImpl(
      {required this.statusCode,
      required this.message,
      required this.data,
      required this.path,
      required this.timestamp,
      required this.success});

  @override
  final int statusCode;
  @override
  final String message;
  @override
  final T? data;
  @override
  final String path;
  @override
  final String timestamp;
  @override
  final bool success;

  @override
  String toString() {
    return 'SuccessResponse<$T>(statusCode: $statusCode, message: $message, data: $data, path: $path, timestamp: $timestamp, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessResponseImpl<T> &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.success, success) || other.success == success));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message,
      const DeepCollectionEquality().hash(data), path, timestamp, success);

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResponseImplCopyWith<T, _$SuccessResponseImpl<T>> get copyWith =>
      __$$SuccessResponseImplCopyWithImpl<T, _$SuccessResponseImpl<T>>(
          this, _$identity);
}

abstract class _SuccessResponse<T> implements SuccessResponse<T> {
  const factory _SuccessResponse(
      {required final int statusCode,
      required final String message,
      required final T? data,
      required final String path,
      required final String timestamp,
      required final bool success}) = _$SuccessResponseImpl<T>;

  @override
  int get statusCode;
  @override
  String get message;
  @override
  T? get data;
  @override
  String get path;
  @override
  String get timestamp;
  @override
  bool get success;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResponseImplCopyWith<T, _$SuccessResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
