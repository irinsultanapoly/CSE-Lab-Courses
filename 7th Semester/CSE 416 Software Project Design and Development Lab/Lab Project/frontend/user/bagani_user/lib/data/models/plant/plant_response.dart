import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_response.g.dart';
part 'plant_response.freezed.dart';

@freezed
class PlantData with _$PlantData {
  const factory PlantData({
    required int id,
    String? name,
    String? species,
    String? description,
    String? imageUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PlantData;

  factory PlantData.fromJson(Map<String, dynamic> json) =>
      _$PlantDataFromJson(json);
}
