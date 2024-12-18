// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlantDataImpl _$$PlantDataImplFromJson(Map<String, dynamic> json) =>
    _$PlantDataImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      species: json['species'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PlantDataImplToJson(_$PlantDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'species': instance.species,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
