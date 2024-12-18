import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_request.freezed.dart';
part 'profile_request.g.dart';

@freezed
class ProfileUpdateReq with _$ProfileUpdateReq {
  const factory ProfileUpdateReq({
    required String name,
    String? email,
    String? address,
    String? profilePicture,
  }) = _ProfileUpdateReq;

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateReqFromJson(json);
}
