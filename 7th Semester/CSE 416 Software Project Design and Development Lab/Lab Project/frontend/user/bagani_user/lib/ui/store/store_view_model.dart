import 'package:bagani/data/repositories/plant_repository.dart';
import 'package:bagani/data/models/plant/plant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class PlantState {
  final List<Plant> plants;
  final bool isLoading;

  PlantState({
    required this.plants,
    required this.isLoading,
  });
}

class StoreViewModel extends StateNotifier<AsyncValue<PlantState>> {
  final PlantRepository _plantRepository;
  final Logger _logger = Logger('PlantViewModel');

  StoreViewModel({
    required PlantRepository plantRepository,
  })  : _plantRepository = plantRepository,
        super(
          const AsyncValue.loading(),
        );

  // Fetch a single plant
  Future<Plant> fetchPlant(int plantId) async {
    try {
      _logger.info('Fetching plant details for plant ID: $plantId');
      // state = const AsyncValue.loading();
      final plantData = await _plantRepository.fetchPlant(plantId);
      return plantData;
    } catch (e, s) {
      _logger.severe(
          'Error fetching plant details for plant ID: $plantId', e, s);
      // state = AsyncValue.error(e, s);
      throw Exception("");
    }
  }

  // Create a new plant
  Future<void> createPlant(int userId, String name, String species,
      String description, String imageUrl) async {
    try {
      _logger.info('Creating a new plant for user ID: $userId');
      state = const AsyncValue.loading();
      final plantData = await _plantRepository.createPlant(
          userId, name, species, description, imageUrl);
      state = AsyncValue.data(
        PlantState(plants: [plantData], isLoading: false),
      );
      _logger.info('Plant created successfully for user ID: $userId');
    } catch (e, s) {
      _logger.severe('Error creating plant for user ID: $userId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  // Update an existing plant
  Future<void> updatePlant(int plantId, String name, String species,
      String description, String imageUrl) async {
    try {
      _logger.info('Updating plant for plant ID: $plantId');
      state = const AsyncValue.loading();
      final plantData = await _plantRepository.updatePlant(
          plantId, name, species, description, imageUrl);
      state = AsyncValue.data(
        PlantState(plants: [plantData], isLoading: false),
      );
      _logger.info('Plant updated successfully for plant ID: $plantId');
    } catch (e, s) {
      _logger.severe('Error updating plant for plant ID: $plantId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  // Delete a plant
  Future<void> deletePlant(int plantId) async {
    try {
      _logger.info('Deleting plant for plant ID: $plantId');
      state = const AsyncValue.loading();
      final isSuccess = await _plantRepository.deletePlant(plantId);
      if (isSuccess) {
        state = AsyncValue.data(
          PlantState(plants: [], isLoading: false),
        );
      } else {
        state =
            const AsyncValue.error('Failed to delete plant', StackTrace.empty);
      }
      _logger.info('Plant deleted successfully for plant ID: $plantId');
    } catch (e, s) {
      _logger.severe('Error deleting plant for plant ID: $plantId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  // Get all plants by user ID
  Future<void> getPlantsByUserId(int userId) async {
    try {
      _logger.info('Fetching plants for user ID: $userId');
      state = const AsyncValue.loading();
      final plantsData = await _plantRepository.getPlantsByUserId(userId);
      _logger.info('plantsData: $plantsData');
      state = AsyncValue.data(
        PlantState(plants: plantsData, isLoading: false),
      );
      _logger.info('Fetched plants successfully for user ID: $userId');
    } catch (e, s) {
      _logger.severe('Error fetching plants for user ID: $userId', e, s);
      state = AsyncValue.error(e, s);
    }
  }

  // Search plants by name and species
  Future<void> searchPlants(String name, String species) async {
    try {
      _logger.info('Searching plants for name: $name, species: $species');
      state = const AsyncValue.loading();
      final searchResults = await _plantRepository.searchPlants(name, species);
      state = AsyncValue.data(
        PlantState(plants: searchResults, isLoading: false),
      );
      _logger
          .info('Plants search completed for name: $name, species: $species');
    } catch (e, s) {
      _logger.severe(
          'Error searching plants for name: $name, species: $species', e, s);
      state = AsyncValue.error(e, s);
    }
  }
}
