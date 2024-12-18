// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlantCreateReqImpl _$$PlantCreateReqImplFromJson(Map<String, dynamic> json) =>
    _$PlantCreateReqImpl(
      name: json['name'] as String,
      species: json['species'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$PlantCreateReqImplToJson(
        _$PlantCreateReqImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'species': instance.species,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

_$PlantUpdateReqImpl _$$PlantUpdateReqImplFromJson(Map<String, dynamic> json) =>
    _$PlantUpdateReqImpl(
      name: json['name'] as String,
      species: json['species'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$PlantUpdateReqImplToJson(
        _$PlantUpdateReqImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'species': instance.species,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
