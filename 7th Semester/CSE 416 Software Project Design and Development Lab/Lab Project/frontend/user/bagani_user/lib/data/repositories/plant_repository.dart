import 'package:bagani/config/providers.dart';
import 'package:bagani/data/models/plant/plant.dart';
import 'package:bagani/data/models/plant/plant_request.dart';
import 'package:bagani/data/services/plant_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class PlantRepository {
  final PlantService _plantService;
  final Ref _ref;
  final Logger _logger = Logger('PlantRepository');

  PlantRepository({required plantService, required ref})
      : _plantService = plantService,
        _ref = ref;

  // Fetch plant details by plant ID
  Future<Plant> fetchPlant(int plantId) async {
    final plantSuccessData = await _ref.read(plantByIdProvider(plantId).future);
    final plantData = plantSuccessData.data;
    if (plantData != null) {
      _logger.info('Fetched plant data');
      return Plant.fromPlantData(plantData.toJson());
    } else {
      throw Exception('Error fetching plant');
    }
  }

  // Create a new plant
  Future<Plant> createPlant(int userId, String name, String species,
      String description, String imageUrl) async {
    final plantCreateReq = PlantCreateReq(
      name: name,
      species: species,
      description: description,
      imageUrl: imageUrl,
    );
    final createSuccessRes =
        await _plantService.createPlant(userId, plantCreateReq);
    final plantData = createSuccessRes.data;
    if (plantData != null) {
      _logger.info('Plant created successfully...');
      _ref.invalidate(plantsByUserIdProvider(
          userId)); // Invalidate user plants cache if needed
      return Plant.fromPlantData(plantData.toJson());
    } else {
      _logger.severe('createPlant => plantData is null!');
      throw Exception('Plant data not present');
    }
  }

  // Update a plant
  Future<Plant> updatePlant(int plantId, String name, String species,
      String description, String imageUrl) async {
    final plantUpdateReq = PlantUpdateReq(
      name: name,
      species: species,
      description: description,
      imageUrl: imageUrl,
    );
    final updateSuccessRes =
        await _plantService.updatePlant(plantId, plantUpdateReq);
    final plantData = updateSuccessRes.data;
    if (plantData != null) {
      _logger.info('Plant updated successfully...');
      return Plant.fromPlantData(plantData.toJson());
    } else {
      _logger.severe('updatePlant => plantData is null!');
      throw Exception('Plant data not present');
    }
  }

  // Delete a plant
  Future<bool> deletePlant(int plantId) async {
    final result = await _plantService.deletePlant(plantId);
    return result.success;
  }

  // Get all plants by user ID
  Future<List<Plant>> getPlantsByUserId(int userId) async {
    try {
      _ref.invalidate(plantsByUserIdProvider(userId));
      final plantsSuccessData =
          await _ref.read(plantsByUserIdProvider(userId).future);
      final plantsData = plantsSuccessData.data;
      if (plantsData!.isNotEmpty) {
        _logger.info('Fetched plants for user size: ${plantsData.length}');
        return plantsData
            .map((plant) => Plant.fromPlantDataRaw(plant))
            .toList();
      } else {
        _logger.severe('getPlantsByUserId => plantsData is null!');
        throw Exception('No plants data found');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Search plants by name and species
  Future<List<Plant>> searchPlants(String name, String species) async {
    final searchResults = await _plantService.searchPlants(name, species);
    final plantsData = searchResults.data;
    if (plantsData != null) {
      _logger.info('Plants search completed');
      return plantsData
          .map((plantData) => Plant.fromPlantData(plantData.toJson()))
          .toList();
    } else {
      _logger.severe('searchPlants => plantsData is null!');
      throw Exception('No matching plants found');
    }
  }
}
