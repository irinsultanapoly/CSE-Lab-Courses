// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlantCreateReq _$PlantCreateReqFromJson(Map<String, dynamic> json) {
  return _PlantCreateReq.fromJson(json);
}

/// @nodoc
mixin _$PlantCreateReq {
  String get name => throw _privateConstructorUsedError;
  String get species =>
      throw _privateConstructorUsedError; // Changed from "type" to "species"
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this PlantCreateReq to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlantCreateReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlantCreateReqCopyWith<PlantCreateReq> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantCreateReqCopyWith<$Res> {
  factory $PlantCreateReqCopyWith(
          PlantCreateReq value, $Res Function(PlantCreateReq) then) =
      _$PlantCreateReqCopyWithImpl<$Res, PlantCreateReq>;
  @useResult
  $Res call(
      {String name, String species, String? description, String? imageUrl});
}

/// @nodoc
class _$PlantCreateReqCopyWithImpl<$Res, $Val extends PlantCreateReq>
    implements $PlantCreateReqCopyWith<$Res> {
  _$PlantCreateReqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlantCreateReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? species = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlantCreateReqImplCopyWith<$Res>
    implements $PlantCreateReqCopyWith<$Res> {
  factory _$$PlantCreateReqImplCopyWith(_$PlantCreateReqImpl value,
          $Res Function(_$PlantCreateReqImpl) then) =
      __$$PlantCreateReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String species, String? description, String? imageUrl});
}

/// @nodoc
class __$$PlantCreateReqImplCopyWithImpl<$Res>
    extends _$PlantCreateReqCopyWithImpl<$Res, _$PlantCreateReqImpl>
    implements _$$PlantCreateReqImplCopyWith<$Res> {
  __$$PlantCreateReqImplCopyWithImpl(
      _$PlantCreateReqImpl _value, $Res Function(_$PlantCreateReqImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlantCreateReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? species = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PlantCreateReqImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantCreateReqImpl implements _PlantCreateReq {
  const _$PlantCreateReqImpl(
      {required this.name,
      required this.species,
      this.description,
      this.imageUrl});

  factory _$PlantCreateReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantCreateReqImplFromJson(json);

  @override
  final String name;
  @override
  final String species;
// Changed from "type" to "species"
  @override
  final String? description;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'PlantCreateReq(name: $name, species: $species, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantCreateReqImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, species, description, imageUrl);

  /// Create a copy of PlantCreateReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantCreateReqImplCopyWith<_$PlantCreateReqImpl> get copyWith =>
      __$$PlantCreateReqImplCopyWithImpl<_$PlantCreateReqImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantCreateReqImplToJson(
      this,
    );
  }
}

abstract class _PlantCreateReq implements PlantCreateReq {
  const factory _PlantCreateReq(
      {required final String name,
      required final String species,
      final String? description,
      final String? imageUrl}) = _$PlantCreateReqImpl;

  factory _PlantCreateReq.fromJson(Map<String, dynamic> json) =
      _$PlantCreateReqImpl.fromJson;

  @override
  String get name;
  @override
  String get species; // Changed from "type" to "species"
  @override
  String? get description;
  @override
  String? get imageUrl;

  /// Create a copy of PlantCreateReq
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlantCreateReqImplCopyWith<_$PlantCreateReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlantUpdateReq _$PlantUpdateReqFromJson(Map<String, dynamic> json) {
  return _PlantUpdateReq.fromJson(json);
}

/// @nodoc
mixin _$PlantUpdateReq {
  String get name => throw _privateConstructorUsedError;
  String get species =>
      throw _privateConstructorUsedError; // Changed from "type" to "species"
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this PlantUpdateReq to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlantUpdateReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlantUpdateReqCopyWith<PlantUpdateReq> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantUpdateReqCopyWith<$Res> {
  factory $PlantUpdateReqCopyWith(
          PlantUpdateReq value, $Res Function(PlantUpdateReq) then) =
      _$PlantUpdateReqCopyWithImpl<$Res, PlantUpdateReq>;
  @useResult
  $Res call(
      {String name, String species, String? description, String? imageUrl});
}

/// @nodoc
class _$PlantUpdateReqCopyWithImpl<$Res, $Val extends PlantUpdateReq>
    implements $PlantUpdateReqCopyWith<$Res> {
  _$PlantUpdateReqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlantUpdateReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? species = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlantUpdateReqImplCopyWith<$Res>
    implements $PlantUpdateReqCopyWith<$Res> {
  factory _$$PlantUpdateReqImplCopyWith(_$PlantUpdateReqImpl value,
          $Res Function(_$PlantUpdateReqImpl) then) =
      __$$PlantUpdateReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String species, String? description, String? imageUrl});
}

/// @nodoc
class __$$PlantUpdateReqImplCopyWithImpl<$Res>
    extends _$PlantUpdateReqCopyWithImpl<$Res, _$PlantUpdateReqImpl>
    implements _$$PlantUpdateReqImplCopyWith<$Res> {
  __$$PlantUpdateReqImplCopyWithImpl(
      _$PlantUpdateReqImpl _value, $Res Function(_$PlantUpdateReqImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlantUpdateReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? species = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PlantUpdateReqImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantUpdateReqImpl implements _PlantUpdateReq {
  const _$PlantUpdateReqImpl(
      {required this.name,
      required this.species,
      this.description,
      this.imageUrl});

  factory _$PlantUpdateReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantUpdateReqImplFromJson(json);

  @override
  final String name;
  @override
  final String species;
// Changed from "type" to "species"
  @override
  final String? description;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'PlantUpdateReq(name: $name, species: $species, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantUpdateReqImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, species, description, imageUrl);

  /// Create a copy of PlantUpdateReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantUpdateReqImplCopyWith<_$PlantUpdateReqImpl> get copyWith =>
      __$$PlantUpdateReqImplCopyWithImpl<_$PlantUpdateReqImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantUpdateReqImplToJson(
      this,
    );
  }
}

abstract class _PlantUpdateReq implements PlantUpdateReq {
  const factory _PlantUpdateReq(
      {required final String name,
      required final String species,
      final String? description,
      final String? imageUrl}) = _$PlantUpdateReqImpl;

  factory _PlantUpdateReq.fromJson(Map<String, dynamic> json) =
      _$PlantUpdateReqImpl.fromJson;

  @override
  String get name;
  @override
  String get species; // Changed from "type" to "species"
  @override
  String? get description;
  @override
  String? get imageUrl;

  /// Create a copy of PlantUpdateReq
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlantUpdateReqImplCopyWith<_$PlantUpdateReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
