import 'dart:convert';
import 'package:bagani/data/models/plant/plant_request.dart';
import 'package:bagani/data/models/plant/plant_response.dart';
import 'package:bagani/data/services/client/api_client.dart';
import 'package:logging/logging.dart';
import '../exceptions/api_exceptions.dart';
import '../models/api_response/error/error_response.dart';
import '../models/api_response/success/success_response.dart';

class PlantService {
  final ApiClient _apiClient;
  final _logger = Logger('PlantService');
  final _basePlantPath = '/api/v1/plants';

  PlantService({required apiClient}) : _apiClient = apiClient;

  Future<SuccessResponse<PlantData>> createPlant(
    int userId,
    PlantCreateReq plantCreateReq,
  ) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/plants?userId=$userId',
        body: plantCreateReq.toJson(),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final plantData = SuccessResponse<PlantData>.fromJson(
          responseBody,
          (data) => PlantData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info('Plant created successfully.');
        return plantData;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Failed to create plant: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Create Plant Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<PlantData>> updatePlant(
    int plantId,
    PlantUpdateReq updatedPlantData,
  ) async {
    try {
      final response = await _apiClient.put(
        '/api/v1/plants/$plantId',
        body: updatedPlantData.toJson(),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final plantData = SuccessResponse<PlantData>.fromJson(
          responseBody,
          (data) => PlantData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info('Plant updated successfully.');
        return plantData;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Failed to update plant: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Update Plant Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<Null>> deletePlant(int plantId) async {
    try {
      final response = await _apiClient.delete(
        '/api/v1/plants/$plantId',
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final result =
            SuccessResponse<Null>.fromJson(responseBody, (data) => null);
        _logger.info('Plant deleted successfully.');
        return result;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Failed to delete plant: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Delete Plant Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<PlantData>> getPlantById(int plantId) async {
    try {
      final response = await _apiClient.get(
        '/api/v1/plants/$plantId',
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final plantData = SuccessResponse<PlantData>.fromJson(
          responseBody,
          (data) => PlantData.fromJson(data as Map<String, dynamic>),
        );
        _logger.info('Fetched plant by ID successfully.');
        return plantData;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Failed to fetch plant: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Get Plant by ID Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<List<PlantData>>> getAllPlantsByUserId(
      int userId) async {
    try {
      final response = await _apiClient.get(
        '/api/v1/plants/user/$userId',
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _logger.info('${responseBody}');
        final plantsList = SuccessResponse<List<PlantData>>.fromJson(
          responseBody,
          (data) => (data as List)
              .map((e) => PlantData.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        _logger.info('Fetched all plants by user ID successfully.');
        return plantsList;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning(
            'Failed to fetch plants by user ID: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Get All Plants by User ID Error', e);
      rethrow;
    }
  }

  Future<SuccessResponse<List<PlantData>>> searchPlants(
    String name,
    String species,
  ) async {
    try {
      final response = await _apiClient.get(
        '/api/v1/plants/search?name=$name&species=$species',
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final plantsList = SuccessResponse<List<PlantData>>.fromJson(
          responseBody,
          (data) => (data as List).map((e) => PlantData.fromJson(e)).toList(),
        );
        _logger.info('Plants search successful.');
        return plantsList;
      } else {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        _logger.warning('Failed to search plants: ${errorResponse.message}');
        throw ApiException.fromErrorResponse(errorResponse);
      }
    } catch (e) {
      _logger.severe('Search Plants Error', e);
      rethrow;
    }
  }
}
