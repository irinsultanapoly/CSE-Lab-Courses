package com.cyclicsoft.bagani_backend.service;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.entity.Plant;

import java.util.List;

public interface IPlantService {

  // Create a new plant
  PlantResponseDTO createPlant(PlantRequestDTO plantRequestDTO, Long userId);

  // Update an existing plant
  PlantResponseDTO updatePlant(Long id, PlantUpdateRequestDTO plantUpdateRequestDTO);

  // Delete a plant by ID
  void deletePlant(Long id);

  // Get a plant by its ID
  PlantResponseDTO getPlantById(Long id);

  // Get all plants of a specific user
  List<PlantResponseDTO> getAllPlantsByUserId(Long userId);

  // Search plants by name or species
  List<PlantResponseDTO> searchPlants(String name, String species);
}
