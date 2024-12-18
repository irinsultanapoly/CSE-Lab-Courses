// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String?,
      mobile: json['mobile'] as String,
      activeStatus: json['activeStatus'] as bool,
      profilePicture: json['profilePicture'] as String?,
      address: json['address'] as String?,
      emailVerified: json['emailVerified'] as bool,
      mobileVerified: json['mobileVerified'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'activeStatus': instance.activeStatus,
      'profilePicture': instance.profilePicture,
      'address': instance.address,
      'emailVerified': instance.emailVerified,
      'mobileVerified': instance.mobileVerified,
    };
