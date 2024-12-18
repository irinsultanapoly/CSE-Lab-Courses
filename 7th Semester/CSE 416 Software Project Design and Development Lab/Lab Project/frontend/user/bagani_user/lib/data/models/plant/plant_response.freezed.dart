// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlantData _$PlantDataFromJson(Map<String, dynamic> json) {
  return _PlantData.fromJson(json);
}

/// @nodoc
mixin _$PlantData {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get species => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PlantData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlantData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlantDataCopyWith<PlantData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantDataCopyWith<$Res> {
  factory $PlantDataCopyWith(PlantData value, $Res Function(PlantData) then) =
      _$PlantDataCopyWithImpl<$Res, PlantData>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? species,
      String? description,
      String? imageUrl,
      String? status,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PlantDataCopyWithImpl<$Res, $Val extends PlantData>
    implements $PlantDataCopyWith<$Res> {
  _$PlantDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlantData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? species = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      species: freezed == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlantDataImplCopyWith<$Res>
    implements $PlantDataCopyWith<$Res> {
  factory _$$PlantDataImplCopyWith(
          _$PlantDataImpl value, $Res Function(_$PlantDataImpl) then) =
      __$$PlantDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? species,
      String? description,
      String? imageUrl,
      String? status,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PlantDataImplCopyWithImpl<$Res>
    extends _$PlantDataCopyWithImpl<$Res, _$PlantDataImpl>
    implements _$$PlantDataImplCopyWith<$Res> {
  __$$PlantDataImplCopyWithImpl(
      _$PlantDataImpl _value, $Res Function(_$PlantDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlantData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? species = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PlantDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      species: freezed == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantDataImpl implements _PlantData {
  const _$PlantDataImpl(
      {required this.id,
      this.name,
      this.species,
      this.description,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory _$PlantDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantDataImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? species;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PlantData(id: $id, name: $name, species: $species, description: $description, imageUrl: $imageUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, species, description,
      imageUrl, status, createdAt, updatedAt);

  /// Create a copy of PlantData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantDataImplCopyWith<_$PlantDataImpl> get copyWith =>
      __$$PlantDataImplCopyWithImpl<_$PlantDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantDataImplToJson(
      this,
    );
  }
}

abstract class _PlantData implements PlantData {
  const factory _PlantData(
      {required final int id,
      final String? name,
      final String? species,
      final String? description,
      final String? imageUrl,
      final String? status,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$PlantDataImpl;

  factory _PlantData.fromJson(Map<String, dynamic> json) =
      _$PlantDataImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get species;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PlantData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlantDataImplCopyWith<_$PlantDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
