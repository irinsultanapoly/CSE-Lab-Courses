import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_request.g.dart';
part 'plant_request.freezed.dart';

@freezed
class PlantCreateReq with _$PlantCreateReq {
  const factory PlantCreateReq({
    required String name,
    required String species, // Changed from "type" to "species"
    String? description,
    String? imageUrl,
  }) = _PlantCreateReq;

  factory PlantCreateReq.fromJson(Map<String, dynamic> json) =>
      _$PlantCreateReqFromJson(json);
}

@freezed
class PlantUpdateReq with _$PlantUpdateReq {
  const factory PlantUpdateReq({
    required String name,
    required String species, // Changed from "type" to "species"
    String? description,
    String? imageUrl,
  }) = _PlantUpdateReq;

  factory PlantUpdateReq.fromJson(Map<String, dynamic> json) =>
      _$PlantUpdateReqFromJson(json);
}
