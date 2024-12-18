// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileUpdateReqImpl _$$ProfileUpdateReqImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileUpdateReqImpl(
      name: json['name'] as String,
      email: json['email'] as String?,
      address: json['address'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$ProfileUpdateReqImplToJson(
        _$ProfileUpdateReqImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
    };
