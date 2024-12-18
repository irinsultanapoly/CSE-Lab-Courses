// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistrationDataImpl _$$RegistrationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistrationDataImpl(
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

Map<String, dynamic> _$$RegistrationDataImplToJson(
        _$RegistrationDataImpl instance) =>
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

_$LoginDataImpl _$$LoginDataImplFromJson(Map<String, dynamic> json) =>
    _$LoginDataImpl(
      token: json['token'] as String,
      userId: (json['userId'] as num).toInt(),
      role: json['role'] as String,
      activeStatus: json['activeStatus'] as bool,
    );

Map<String, dynamic> _$$LoginDataImplToJson(_$LoginDataImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'role': instance.role,
      'activeStatus': instance.activeStatus,
    };
