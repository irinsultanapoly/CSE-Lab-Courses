package com.cyclicsoft.bagani_backend.service.impl;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.entity.Plant;
import com.cyclicsoft.bagani_backend.entity.Plant.PlantStatus;
import com.cyclicsoft.bagani_backend.exception.ResourceNotFoundException;
import com.cyclicsoft.bagani_backend.mapper.IPlantMapper;
import com.cyclicsoft.bagani_backend.repository.PlantRepository;
import com.cyclicsoft.bagani_backend.repository.UserRepository;
import com.cyclicsoft.bagani_backend.service.IPlantService;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PlantServiceImpl implements IPlantService {

  private final PlantRepository plantRepository;
  private final UserRepository userRepository;
  private final IPlantMapper plantMapper;

  // Create a new plant
  @Override
  @Transactional
  public PlantResponseDTO createPlant(PlantRequestDTO plantRequestDTO, Long userId) {
    Plant plant = plantMapper.toPlant(plantRequestDTO, userId);

    plant.setStatus(PlantStatus.AVAILABLE);
    plant.setUser(userRepository.getReferenceById(userId));
    plantRepository.save(plant);
    return plantMapper.toPlantResponseDTO(plant);
  }

  // Update an existing plant
  @Override
  @Transactional
  public PlantResponseDTO updatePlant(Long id, PlantUpdateRequestDTO plantUpdateRequestDTO) {
    Plant plant = plantRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Plant not found with id " + id));
    plant.setName(plantUpdateRequestDTO.getName());
    plant.setDescription(plantUpdateRequestDTO.getDescription());
    plant.setImageUrl(plantUpdateRequestDTO.getImageUrl());
    plant.setSpecies(plantUpdateRequestDTO.getSpecies());
    plantRepository.save(plant);
    return plantMapper.toPlantResponseDTO(plant);
  }

  // Delete a plant by ID
  @Override
  @Transactional
  public void deletePlant(Long id) {
    Plant plant = plantRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Plant not found with id " + id));
    plantRepository.delete(plant);
  }

  // Get a plant by its ID
  @Override
  public PlantResponseDTO getPlantById(Long id) {
    Plant plant = plantRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Plant not found with id " + id));
    return plantMapper.toPlantResponseDTO(plant);
  }

  // Get all plants of a specific user
  @Override
  public List<PlantResponseDTO> getAllPlantsByUserId(Long userId) {
    List<Plant> plants = plantRepository.findAllByUser_Id(userId);
    return plants.stream()
        .map(plantMapper::toPlantResponseDTO)
        .collect(Collectors.toList());
  }

  // Search plants by name or species
  @Override
  public List<PlantResponseDTO> searchPlants(String name, String species) {
    List<Plant> plants;
    if (name != null && species != null) {
      plants = plantRepository.findByNameContainingIgnoreCaseAndSpeciesContainingIgnoreCase(name, species);
    } else if (name != null) {
      plants = plantRepository.findByNameContainingIgnoreCase(name);
    } else if (species != null) {
      plants = plantRepository.findBySpeciesContainingIgnoreCase(species);
    } else {
      plants = plantRepository.findAll();
    }
    return plants.stream()
        .map(plantMapper::toPlantResponseDTO)
        .collect(Collectors.toList());
  }
}
