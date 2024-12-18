// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileDataImpl _$$ProfileDataImplFromJson(Map<String, dynamic> json) =>
    _$ProfileDataImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String?,
      mobile: json['mobile'] as String,
      activeStatus: json['activeStatus'] as bool,
      profilePicture: json['profilePicture'] as String?,
      address: json['address'] as String?,
      role: json['role'] as String,
      emailVerified: json['emailVerified'] as bool,
      mobileVerified: json['mobileVerified'] as bool,
    );

Map<String, dynamic> _$$ProfileDataImplToJson(_$ProfileDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'activeStatus': instance.activeStatus,
      'profilePicture': instance.profilePicture,
      'address': instance.address,
      'role': instance.role,
      'emailVerified': instance.emailVerified,
      'mobileVerified': instance.mobileVerified,
    };
